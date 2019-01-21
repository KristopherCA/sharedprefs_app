import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SharedPrefs(),
    );
  }
}

class SharedPrefs extends StatefulWidget {
  @override
  _SharedPrefsState createState() => _SharedPrefsState();
}

class _SharedPrefsState extends State<SharedPrefs> {
  String _savedData = "";
  var sharedprefsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data') != null &&
          preferences.getString('data').isNotEmpty) {
        _savedData = preferences.getString('data');
      } else {
        _savedData = "Empty";
      }
    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message); //key/value pair
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Prefs'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: sharedprefsController,
                decoration: InputDecoration(labelText: 'Enter data'),
              ),
            ),
            ListTile(
              title: RaisedButton(
                  color: Colors.deepOrange,
                  onPressed: () {
                    _saveMessage(sharedprefsController.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Save Data',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          _savedData,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
