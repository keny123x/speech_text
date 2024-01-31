import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text Demo',
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = 'Presiona el botón para empezar a hablar';
  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to Text Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleListening,
              child: _isListening ? Text('Detener reconocimiento') : Text('Iniciar reconocimiento'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _text = 'Escuchando...';
        });
        _speech.listen(onResult: (result) {
          setState(() {
            _text = result.recognizedWords;
          });
        });
      } else {
        setState(() {
          _text = 'El reconocimiento de voz no está disponible';
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _text = 'Presiona el botón para empezar a hablar';
      });
      _speech.stop();
    }
  }
}
