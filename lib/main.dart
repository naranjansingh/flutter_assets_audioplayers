import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  Future<void> _playAudio() async {
    int result = await _audioPlayer.play('assets/audio/sample.mp3', isLocal: true);
    if (result == 1) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _pauseAudio() async {
    int result = await _audioPlayer.pause();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  Future<void> _stopAudio() async {
    int result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Audio Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isPlaying ? Icons.volume_up : Icons.volume_off,
              size: 100,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isPlaying ? _pauseAudio : _playAudio,
              child: Text(_isPlaying ? 'Pause' : 'Play'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _stopAudio,
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AudioPlayerPage(),
    theme: ThemeData(
      primarySwatch: Colors.purple,
    ),
  ));
}
