import 'package:flutter/material.dart';
import 'package:flutter_ui/pet_finder.dart';
import 'package:flutter_ui/pet.dart';
import 'package:flutter_ui/pets_api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awwdoption demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/pets': (context) => PetsListScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final client = http.Client();

  Pet _currentPet = Pet();
  @override
  void initState() {
    super.initState();
    _currentPet.setName(PetFinder().findName());
    _currentPet.setImageUrl(PetFinder().findImageUrl());
  }

  void _viewNewPet() {
    setState(() {
      _currentPet.setName(PetFinder().findName());
      _currentPet.setImageUrl(PetFinder().findImageUrl());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Adoption Center'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Adopt a pet today!',
              style: Theme.of(context).textTheme.headline4,
            ),
            Image.network(
              _currentPet.imageUrl,
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : LinearProgressIndicator();
              },
              fit: BoxFit.contain,
            ),
            Text(
              _currentPet.name,
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text(_currentPet.name + ' was happy to be pet :)'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              tooltip: 'Pet the Animal',
              child: Icon(Icons.pets),
            ),
            ElevatedButton(
                child: Text('Adopt This Pet'),
                onPressed: () {
                  PetsApiClient().postPet(client, _currentPet);
                  Navigator.pushNamed(context, '/pets');
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewNewPet,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class PetsListScreen extends StatefulWidget {
  PetsListScreen();

  @override
  _PetsListScreenState createState() => _PetsListScreenState();
}

class _PetsListScreenState extends State<PetsListScreen> {
  Future<List<Pet>> futurePetsList;
  final client = http.Client();
  @override
  void initState() {
    super.initState();
    futurePetsList = PetsApiClient().getPetsList(client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Pets'),
      ),
      body: Center(
        child: FutureBuilder(
            future: futurePetsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data[index].name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PetDetailScreen(pet: snapshot.data[index]),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}

class PetDetailScreen extends StatefulWidget {
  final Pet pet;

  const PetDetailScreen({Key key, @required this.pet}) : super(key: key);

  @override
  _PetDetailScreenState createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.pet.name}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Image.network(
              widget.pet.imageUrl,
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : LinearProgressIndicator();
              },
              fit: BoxFit.contain,
            ),
            Text(
              'You have pet ${widget.pet.name} ${widget.pet.timesPet} times',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              onPressed: () {
                //todo: send PUT request updating number of times pet
                final snackBar = SnackBar(
                  content: Text('${widget.pet.name} was happy to be pet :)'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              tooltip: 'Pet the Animal',
              child: Icon(Icons.pets),
            ),
            ElevatedButton(
                child: Text('Return ${widget.pet.name} to Shelter'),
                onPressed: () {
                  // TODO: send DELETE request to remove pet from DB
                  Navigator.pushNamed(context, '/home');
                })
          ],
        ),
      ),
    );
  }
}
