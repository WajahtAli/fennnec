import 'dart:async';
import 'dart:developer';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../helpers/assets_to_file_converter.dart';
import '../state/audio_player_state.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer _player = AudioPlayer();
  final _waveformController = WaveformExtractionController();
  StreamSubscription? _posSub;
  StreamSubscription? _durSub;

  AudioPlayerCubit() : super(AudioPlayerState.initial()) {
    _listen();
  }

  void _listen() {
    _posSub = _player.positionStream.listen((pos) {
      if (!isClosed) emit(state.copyWith(position: pos));
    });

    _durSub = _player.durationStream.listen((dur) {
      if (!isClosed) emit(state.copyWith(duration: dur ?? Duration.zero));
    });

    _player.playerStateStream.listen((playerState) async {
      if (isClosed) return;
      log('Player state changed: $playerState');

      switch (playerState.processingState) {
        case ProcessingState.completed:
          await _player.stop();
          _player.seek(Duration.zero);
          _player.pause();
          emit(
            state.copyWith(
              status: AudioStatus.stopped,
              position: Duration.zero,
            ),
          );
          break;

        case ProcessingState.ready:
          if (playerState.playing) {
            emit(state.copyWith(status: AudioStatus.playing));
          } else {
            emit(state.copyWith(status: AudioStatus.paused));
          }
          break;

        case ProcessingState.loading:
        case ProcessingState.buffering:
          emit(state.copyWith(status: AudioStatus.loading));
          break;

        case ProcessingState.idle:
          emit(state.copyWith(status: AudioStatus.idle));
          break;
      }
    });
  }

  Future<void> setSource(String path) async {
    if (isClosed) return;
    try {
      emit(state.copyWith(status: AudioStatus.loading, path: path));

      if (path.startsWith('assets/')) {
        await _player.setAsset(path);
      } else if (path.startsWith('http')) {
        await _player.setUrl(path);
      } else {
        await _player.setFilePath(path);
      }
      if (!isClosed) emit(state.copyWith(status: AudioStatus.paused));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> toggle() async {
    if (isClosed) return;
    if (_player.playing) {
      await _player.pause();
      if (!isClosed) emit(state.copyWith(status: AudioStatus.paused));
    } else {
      await _player.play();
      if (!isClosed) emit(state.copyWith(status: AudioStatus.playing));
    }
  }

  Future<void> play() async {
    if (isClosed) return;
    await _player.play();
    if (!isClosed) emit(state.copyWith(status: AudioStatus.playing));
  }

  Future<void> pause() async {
    if (isClosed) return;
    await _player.pause();
    if (!isClosed) emit(state.copyWith(status: AudioStatus.paused));
  }

  Future<void> seek(double ratio) async {
    if (state.duration.inMilliseconds == 0) return;
    final ms = (state.duration.inMilliseconds * ratio).toInt();
    await _player.seek(Duration(milliseconds: ms));
  }

  void addWaveformData(List<double> data) {
    if (isClosed) return;
    emit(state.copyWith(waveformData: _normalizeWaveform(data)));
  }

  Future<void> extractWaveForms() async {
    if (isClosed) return;
    emit(state.copyWith(waveformData: []));
    if (state.path == null || state.path!.isEmpty) return;
    String path = state.path!;
    if (path.startsWith('assets/')) {
      path = await assetToFile(path);
    }
    List<double> data = await _waveformController.extractWaveformData(
      path: path,
      noOfSamples: 120,
    );
    if (!isClosed) {
      emit(state.copyWith(waveformData: _normalizeWaveform(data)));
    }
  }

  List<double> _normalizeWaveform(
    List<double> data, {
    double minHeight = 100.0,
  }) {
    return data.map((e) => e > 0 ? e * minHeight : 1.0).toList();
  }

  @override
  Future<void> close() {
    _posSub?.cancel();
    _durSub?.cancel();
    _player.dispose();
    return super.close();
  }
}
