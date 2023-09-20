import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double _sliderValue = 0.5; // Initial value

  Color getColorForSliderValue(double value) {
    // Logic to determine color based on slider value
    if (value < 0.25) {
      return Colors.red;
    } else if (value < 0.5) {
      return Colors.orange;
    } else if (value < 0.75) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getColorForSliderValue(_sliderValue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      backgroundColor: backgroundColor, // Set the background color here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Baseline(
              baseline: 0,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                'Baseline Text',
                style: TextStyle(fontSize: 24),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
            const Text('This is the Second Page'),
            Slider(
              value: _sliderValue,
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              min: 0,
              max: 1,
            ),
          ],
        ),
      ),
    );
  }
}


