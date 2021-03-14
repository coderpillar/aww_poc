import 'package:flutter/material.dart';
import 'package:flutter_ui/pet_finder.dart';
import 'package:flutter_ui/pet.dart';

void main() {
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
      home: HomeScreen(title: 'Pet Adoption Center'),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/pets': (context) => PetsListScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Pet _currentPet = Pet(PetFinder().findName(), PetFinder().findImageUrl());

  void _viewNewPet() {
    setState(() {
      _currentPet.setName(PetFinder().findName());
      _currentPet.setImageUrl(PetFinder().findImageUrl());
    });
  }

  void _petCurrentPet() {
    _currentPet.incrementTimesPet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                _petCurrentPet();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Pets'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pets list goes here.',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
