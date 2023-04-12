
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';


class SoundRecorder {
  static final audioSavePath = 'voice_audio.aac';
  // final audioPlayer = AudioPlayer();
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;

  //playback
  // FlutterSoundPlayer? _audioPlayer;
  // bool isPlayerInitialized = false;
  // bool isPlaying = false;

  bool get isRecording => _audioRecorder!.isRecording;


  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$audioSavePath';
  }

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('permiss microphone');
    }

    await _audioRecorder!.openAudioSession();
    // await _audioPlayer!.openAudioSession();
    _isRecorderInitialized = true;
    // isPlayerInitialized = true;
  }

  void dispose () {
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
  }
  Future _record() async {
    if (!_isRecorderInitialized) return;
    final filePath = await getFilePath();
    await _audioRecorder!.startRecorder(toFile: filePath);
  }
  Future _stop() async {
    if (!_isRecorderInitialized) return;

    await _audioRecorder!.stopRecorder();



  }
  // Future _play() async {
  //   if (!isPlayerInitialized) return;
  //   await audioPlayer.play(audioSavePath);
  //   isPlaying = true;
  // }

  // Future _stopPlayback() async {
  //   if (!isPlayerInitialized) return;
  //   await audioPlayer!.stopPlayer();
  //   isPlaying = false;
  // }


  Future toggleRecording() async {
    if(_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }

  // Future togglePlay() async {
  //   if(audioPlayer!.isStopped) {
  //     await _play();
  //   } else {
  //     await _stopPlayback();
  //   }
  // }
}