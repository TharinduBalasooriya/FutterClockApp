import 'package:audioplayers/audioplayers.dart';

class AudioService {
  late AudioCache _audioCache;
  late AudioPlayer _audioPlayer;
  AudioService() {
    _audioCache = AudioCache();
  }

  play(String tone) async {
    _audioPlayer = await _audioCache.play('$tone.mp3');
  }

  stop() {
    _audioPlayer.stop();
  }
}
