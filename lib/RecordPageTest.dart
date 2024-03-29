import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:path_provider/path_provider.dart';

import 'dart:io';
//VIDEO: https://www.youtube.com/watch?v=Bxn8k9F5JiM
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordPage extends StatefulWidget {
  final String patientName;
  const RecordPage({Key? key, required this.patientName}) : super(key: key);


  @override
  State<RecordPage> createState() => _RecordPageState();
}


class _RecordPageState extends State<RecordPage> {
  int _counter = 0;
  String? _response;
  //Use to conditioally render send button
  bool _isRecordingDone = false;
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }

  @override
  void dispose() {
    recorder.stopRecorder();
    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openAudioSession();

    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  Future record() async {
    resetResponse();
    if (!isRecorderReady) return;
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/audio.wav';
    await recorder.startRecorder(toFile: filePath, codec: Codec.pcm16WAV);

  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print('Recorded audio: $audioFile');
    _isRecordingDone = true;
  }

  void resetResponse() {
    setState(() {
      _response = null;
    });
  }


  Future<void> sendAudioFile(String filePath) async {
    //https://Jays-Feeling-App.danielcarter25.repl.co/analyze
    final url = Uri.parse('http://52.53.254.134:5000/fetch_prediction');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath(
      'audio',
      filePath,
      contentType: MediaType('audio', 'wav'),
    ));
    final response = await request.send();
    final responseBodyBytes = await response.stream.toBytes();
    final responseBody = utf8.decode(responseBodyBytes);

    if (response.statusCode == 200) {
      print('Uploaded successfully');
      setState(() {
        _response = responseBody;

        _isRecordingDone = false;
      });
    } else {
      print('Upload failed: ${response.statusCode}, Response: $responseBody');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patientName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration = snapshot.hasData ? snapshot.data!.duration: Duration.zero;

                String twoDigits(int n) => n.toString().padLeft(2);
                final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                final twoDigitSeconds= twoDigits(duration.inSeconds.remainder(60));

                return Text(
                    '$twoDigitMinutes:$twoDigitSeconds',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                    )
                );
              },
            ),
            ElevatedButton(
              child: Icon(
                recorder.isRecording ? Icons.stop : Icons.mic,
                size: 80,
              ),
              onPressed: () async {
                if (recorder.isRecording) {
                  await stop();
                } else {
                  await record();
                }
                setState(() {});
              },
            ),

            ElevatedButton(
              child: Text("Send"),
              onPressed: _isRecordingDone
                  ? () async {
                final path = '/data/user/0/com.app.jay_feeling/cache/audio.wav';
                await sendAudioFile(path!);
              }
                  : null,
            ),
            if (_response != null) Text(_response!),
          ],
        ),
      ),
    );
  }
}