// import 'package:flutter_sound/flutter_sound.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
//
//
// FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//
//
// class RecordAudioScreen extends StatefulWidget {
//   @override
//   _RecordAudioScreenState createState() => _RecordAudioScreenState();
// }
//
// class _RecordAudioScreenState extends State<RecordAudioScreen> {
//   String? _audioFilePath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Record Audio')),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ElevatedButton.icon(
//             onPressed: _recordAudio,
//             icon: Icon(Icons.mic),
//             label: Text('Record'),
//           ),
//           ElevatedButton.icon(
//             onPressed: _stopRecording,
//             icon: Icon(Icons.stop),
//             label: Text('Stop'),
//           ),
//           ElevatedButton.icon(
//             onPressed: _audioFilePath != null ? _sendAudio : null,
//             icon: Icon(Icons.send),
//             label: Text('Send'),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   void _sendAudio() async {
//     Uri url = Uri.parse("https://your-replit-app-url/receive_audio");
//     File audioFile = File(_audioFilePath!);
//     List<int> audioBytes = await audioFile.readAsBytes();
//
//     http.MultipartRequest request = http.MultipartRequest('POST', url);
//     request.files.add(http.MultipartFile.fromBytes(
//         'audio', audioBytes, filename: 'audio.m4a'));
//
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       print("Audio sent successfully");
//     } else {
//       print("Failed to send audio");
//     }
//   }
//
//   void _recordAudio() async {
//     // Initialize the recorder
//     await _recorder.openAudioSession();
//
//     // Create the audio file path
//     Directory tempDir = await getTemporaryDirectory();
//     String audioFileName = 'my_audio_file.m4a';
//     _audioFilePath = '${tempDir.path}/$audioFileName';
//
//     // Start recording
//     await _recorder.startRecorder(toFile: _audioFilePath);
//   }
//
//   void _stopRecording() async {
//     // Stop recording
//     await _recorder.stopRecorder();
//     // Close the recorder
//     await _recorder.closeAudioSession();
//   }
// //
// //   void _sendAudio() {
// //     // Implement logic to send the recorded audio file to the Flask server
// //   }
// // }
// }
