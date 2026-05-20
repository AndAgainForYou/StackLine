import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class SoundService {
  SoundService() {
    _placePlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _clearPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _invalidPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _pickupPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _rotatePlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
    _gameOverPlayer = AudioPlayer()..setReleaseMode(ReleaseMode.stop);
  }

  late final AudioPlayer _placePlayer;
  late final AudioPlayer _clearPlayer;
  late final AudioPlayer _invalidPlayer;
  late final AudioPlayer _pickupPlayer;
  late final AudioPlayer _rotatePlayer;
  late final AudioPlayer _gameOverPlayer;

  bool enabled = true;
  bool _disposed = false;

  Future<void> playPlace() => _play(_placePlayer, AssetSource('sounds/place.wav'));
  Future<void> playClear() => _play(_clearPlayer, AssetSource('sounds/clear.wav'));
  Future<void> playInvalid() => _play(_invalidPlayer, AssetSource('sounds/invalid.wav'));
  Future<void> playPickup() => _play(_pickupPlayer, AssetSource('sounds/pickup.wav'));
  Future<void> playRotate() => _play(_rotatePlayer, AssetSource('sounds/rotate.wav'));
  Future<void> playGameOver() => _play(_gameOverPlayer, AssetSource('sounds/gameover.wav'));

  Future<void> _play(AudioPlayer player, AssetSource source) async {
    if (!enabled || _disposed) return;
    try {
      await player.stop();
      await player.play(source, volume: 0.6);
    } catch (e) {
      debugPrint('Sound play failed: $e');
    }
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    enabled = false;

    for (final player in [
      _placePlayer,
      _clearPlayer,
      _invalidPlayer,
      _pickupPlayer,
      _rotatePlayer,
      _gameOverPlayer,
    ]) {
      try {
        await player.dispose();
      } catch (e) {
        debugPrint('Sound dispose failed: $e');
      }
    }
  }
}
