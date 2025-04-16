import 'package:flutter/material.dart';

class TextToSpeechConverter extends StatefulWidget {
  @override
  _TextToSpeechConverterState createState() => _TextToSpeechConverterState();
}

class _TextToSpeechConverterState extends State<TextToSpeechConverter> {
  String text = '';
  bool isSending = false;
  String error = '';
  bool showResult = false;
  String convertedText = '';

  void handleSend() {
    if (text.trim().isEmpty) {
      setState(() {
        error = 'Please enter some text to convert';
      });
      return;
    }

    setState(() {
      error = '';
      isSending = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isSending = false;
        convertedText = text; 
        showResult = true;
      });
    });
  }

  void handleBack() {
    setState(() {
      showResult = false;
      text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showResult) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Speech Conversion Result'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: handleBack,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Original Text',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(convertedText),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  border: Border.all(color: Colors.blue[200]!),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simulated Output',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'In a real implementation, this text would be converted to speech by the ESP32 device. The audio would play through connected speakers.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                        },
                        icon: Icon(Icons.volume_up),
                        label: Text('Play Simulated Audio'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32 Text-to-Speech Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter text to convert to speech...',
                border: OutlineInputBorder(),
              ),
              minLines: 5,
              maxLines: 10,
              enabled: !isSending,
            ),
            if (error.isNotEmpty) ...[
              SizedBox(height: 8.0),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isSending ? null : handleSend,
              child: isSending
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          value: null,
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.0),
                        Text('Converting to Speech...'),
                      ],
                    )
                  : Text('Convert to Speech'),
            ),
          ],
        ),
      ),
    );
  }
}