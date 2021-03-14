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
      home: AdoptionPage(title: 'Pet Adoption Center'),
    );
  }
}

class AdoptionPage extends StatefulWidget {
  AdoptionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AdoptionPageState createState() => _AdoptionPageState();
}

class _AdoptionPageState extends State<AdoptionPage> {
  Pet _currentPet = Pet(PetFinder().findName(), PetFinder().findImageUrl());

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
              _candidatePetImageUrl,
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : LinearProgressIndicator();
              },
            ),
            Text(
              '$_candidatePetName',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewNewPet,
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
