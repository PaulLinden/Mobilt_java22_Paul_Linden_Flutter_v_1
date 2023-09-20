import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'secondpage.dart';

BuildContext? savedContext;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _textDisplayed = 'You have pushed the button this many times:';
  TextEditingController _textFieldController = TextEditingController();
  String _savedText = '';

  @override
  void initState() {
    super.initState();
    _loadSavedText();

    // Add a listener to the text field
    _textFieldController.addListener(_saveCurrentText);
  }

  void _saveCurrentText() async {
    String enteredText = _textFieldController.text;
    await _saveText(enteredText);
  }

  Future<void> _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString('savedText') ?? '';
      _textFieldController.text = _savedText; // Set the text field value
    });
  }

  Future<void> _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedText', text);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;

      if (_counter == 10) {
        _textDisplayed = 'STOPPPPPP YOU MOTHERFFFER!!!';
      }

      if (_counter == 15) {
        _textDisplayed = '!!!PSYCHO!!!!!';
      }

      if (_counter == 20) {
        _textDisplayed = 'You have pushed the button this (too)many times:';
        _counter = 0;
      }
    });
  }

  Future<void> _navigateToSecondPage() async {
    String enteredText = _textFieldController.text;
    await _saveText(enteredText);

    // Använd tidigare sparat BuildContext här
    Navigator.push(
      savedContext!,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/mobilephone.png',
              width: 200,
              height: 200,
            ),
            TextFormField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: 'Enter your text',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String enteredText = _textFieldController.text;
                await _saveText(enteredText);

                // Spara BuildContext innan async-operationen
                savedContext = context;

                await _navigateToSecondPage();
              },
              child: const Text('Go to Second Page'),
            ),
            Text(
              _textDisplayed,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Saved Text: $_savedText',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}



