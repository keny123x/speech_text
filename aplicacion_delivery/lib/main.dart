import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text-to-Speech Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextToSpeechDemo(),
    );
  }
}

class TextToSpeechDemo extends StatefulWidget {
  @override
  _TextToSpeechDemoState createState() => _TextToSpeechDemoState();
}

class _TextToSpeechDemoState extends State<TextToSpeechDemo> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    flutterTts.setLanguage('es-ES');
    // Ajustar la velocidad de habla
    flutterTts.setSpeechRate(0.7);
  }

  Future<void> speak() async {
    // Agregar una pausa al final del texto
    String text = textEditingController.text ;

    // Enfatizar ciertas palabras
    text = text.replaceAll('importante', '<emphasis level="strong">importante</emphasis>');

    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text-to-Speech Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Ingrese el texto a convertir en voz',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: speak,
              child: Text('Hablar'),
            ),
          ],
        ),
      ),
    );
  }
}
