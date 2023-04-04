import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioHandler {
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  bool _isRecorderInitialized = false;
  bool _isPlayerInitialized = false;

  bool get isRecording => _audioRecorder!.isRecording;

  bool get isPlaying => _audioPlayer!.isPlaying;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('permiss microphone');
    }

    await _audioRecorder!.openAudioSession();
    await _audioPlayer!.openAudioSession();
    _isRecorderInitialized = true;
    _isPlayerInitialized = true;
  }

  void dispose() {
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;

    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
    _isPlayerInitialized = false;
  }

  Future record(String audioPath) async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.startRecorder(toFile: audioPath);
  }

  Future stopRecording() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();
  }

  Future play(String audioPath) async {
    if (!_isPlayerInitialized) return;

    await _audioPlayer!.startPlayer(fromURI: audioPath);
  }

  Future stopPlaying() async {
    if (!_isPlayerInitialized) return;
    await _audioPlayer!.stopPlayer();
  }
}
