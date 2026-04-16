import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:equatable/equatable.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/core/extensions/string_extension.dart';
import 'package:fennac_app/pages/auth/domain/usecases/create_account_usecase.dart';
import 'package:fennac_app/pages/kyc/data/model/custom_prompt.dart';
import 'package:fennac_app/pages/kyc/presentation/bloc/state/kyc_prompt_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../../auth/presentation/bloc/cubit/create_account_cubit.dart';

class AudioPromptData extends Equatable {
  final String? id;
  final String? oldId;
  final String? promptText;
  final String? promptAnswer;
  final List<double>? waveformData;
  final String? duration;
  final bool? isCustom;

  const AudioPromptData({
    this.id,
    this.oldId,
    this.promptText,
    this.promptAnswer,
    this.waveformData,
    this.duration,
    this.isCustom,
  });

  AudioPromptData copyWith({
    String? id,
    String? oldId,
    String? promptText,
    String? promptAnswer,
    List<double>? waveformData,
    String? duration,
    bool? isCustom,
  }) {
    final newAnswer = promptAnswer ?? this.promptAnswer;

    return AudioPromptData(
      id: id ?? this.id,
      oldId: oldId ?? this.oldId,
      promptText: promptText ?? this.promptText,
      promptAnswer: newAnswer,
      waveformData: waveformData ?? this.waveformData,
      duration: duration ?? this.duration,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  @override
  List<Object?> get props => [
    id,
    promptText,
    promptAnswer,
    waveformData,
    duration,
    isCustom,
  ];
}

class KycPromptCubit extends Cubit<KycPromptState> {
  KycPromptCubit() : super(KycPromptInitial());

  final ScrollController scrollController = ScrollController();

  // new flow
  List<AudioPromptData> selectedPrompts = [];
  // user prompts
  List<AudioPromptData> userPrompts = [];

  CustomPromptModel? customPromptModel;

  // Maximum allowed prompts
  static const int maxPrompts = 4;

  // Bottom sheet visibility
  bool _showBottomSheet = false;
  bool get showBottomSheet => _showBottomSheet;

  bool isAudioMode = false;

  // adding prompt
  void addPrompt(AudioPromptData prompt) {
    emit(KycPromptLoading());
    selectedPrompts.add(prompt);
    emit(KycPromptLoaded());
  }

  // remove prompt
  void removePrompt(String prompt) {
    emit(KycPromptLoading());
    selectedPrompts.removeWhere(
      (e) => e.promptText?.makeSearchAble() == prompt.makeSearchAble(),
    );
    emit(KycPromptLoaded());
  }

  // update prompt
  void updatePrompt(AudioPromptData prompt) {
    emit(KycPromptLoading());
    selectedPrompts[selectedPrompts.indexWhere(
          (e) => e.id == prompt.id || e.oldId == prompt.oldId,
        )] =
        prompt;
    emit(KycPromptLoaded());
  }

  // clear all prompts
  void clearAllPrompts() {
    emit(KycPromptLoading());
    selectedPrompts.clear();
    emit(KycPromptLoaded());
  }

  // ==================== AUDIO CONTROLLERS (Owned by Cubit) ====================
  final RecorderController _recorderController = RecorderController();

  // ==================== AUDIO STATE (Single Source of Truth) ====================
  String? recordingPath;
  bool isRecording = false;
  bool isRecordingPaused = false;
  bool isRecorded = false;
  bool isPlaying = false;
  List<double> recordedWaveformData = [];
  String recordedDuration = '00:00';

  // ==================== TIMER STATE (Owned by Cubit) ====================
  Timer? _recordTimer;
  Duration _recordingElapsed = Duration.zero;

  Duration get recordingElapsed => _recordingElapsed;

  // Expose controllers to widgets (but widgets should only read, not manipulate)
  RecorderController get recorderController => _recorderController;
  StreamSubscription<Amplitude>? amplitudeSub;

  void toggleAudioMode() {
    emit(KycPromptLoading());
    isAudioMode = !isAudioMode;
    emit(KycPromptLoaded());
  }

  AudioPromptData? promptToEdit;

  void initializePromptState({required AudioPromptData prompt}) {
    emit(KycPromptLoading());
    promptToEdit = prompt;
    resetRecording();

    if (prompt.promptAnswer?.isAudio ?? false) {
      isAudioMode = true;
      isRecorded = true;
    } else {
      isAudioMode = false;
    }
    emit(KycPromptLoaded());
  }

  // reset recording state
  void resetRecording() {
    emit(KycPromptLoading());
    recordingPath = null;
    isRecording = false;
    isRecordingPaused = false;
    isRecorded = false;
    isPlaying = false;
    recordedWaveformData = [];
    recordedDuration = '00:00';
    _recordingElapsed = Duration.zero;
    emit(KycPromptLoaded());
  }

  // reset all data
  void resetAllData() {
    emit(KycPromptLoading());
    selectedPrompts.clear();

    resetRecording();
    emit(KycPromptLoaded());
  }

  // add audio prompt data
  void addAudioPromptData(
    String? id,
    String prompt,
    String audioPath,
    bool isAudio,
    List<double> waveformData,
    String duration,
  ) {
    emit(KycPromptLoaded());
  }

  // ==================== RECORDING CONTROL ====================
  final record = AudioRecorder();

  /// Start recording a new audio prompt
  Future<void> startRecording() async {
    try {
      emit(KycPromptLoading());

      // Check permissions first
      final hasPermission = await record.hasPermission();
      if (!hasPermission) {
        log('Recording permission not granted');
        emit(KycPromptError());
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await record.start(
        RecordConfig(
          androidConfig: AndroidRecordConfig(
            audioManagerMode: AudioManagerMode.modeInCommunication,
            service: AndroidService(
              title: 'Fennec Audio Recording',
              content: "Recording audio for KYC prompt",
            ),
          ),
          noiseSuppress: true,
          encoder: AudioEncoder.wav,
          iosConfig: IosRecordConfig(
            categoryOptions: [
              IosAudioCategoryOption.allowBluetooth,
              IosAudioCategoryOption.defaultToSpeaker,
            ],
          ),
        ),
        path: path,
      );
      recordingPath = path;
      isRecording = true;
      isRecordingPaused = false;
      isRecorded = false;
      isPlaying = false;
      recordedWaveformData = [];
      recordedDuration = '00:00';
      _startWaveformStream();
      _startTimer();
      emit(KycPromptLoaded());
    } catch (e) {
      log('Error starting recording: $e');
      emit(KycPromptError());
      rethrow;
    }
  }

  void _startWaveformStream() {
    amplitudeSub?.cancel();

    amplitudeSub = record
        .onAmplitudeChanged(const Duration(milliseconds: 60))
        .listen((amp) {
          emit(KycPromptLoading());
          final barHeight = processWaveform(amp.current);
          recordedWaveformData.add(barHeight);
          if (scrollController.hasClients) {
            scrollController.jumpTo(
              scrollController.position.maxScrollExtent + 10,
            );
          }
          if (recordedWaveformData.length > 120) {
            recordedWaveformData.removeAt(30);
          }
          debugPrint('Amplitude: ${amp.current}, WaveValue: $barHeight');
          emit(KycPromptLoaded());
        });
  }

  double _smoothedValue = 0.0;
  double _previousHeight = 0.0;

  double silenceThreshold = -55.0;
  double smoothingFactor = 0.2;
  double decayFactor = 0.85;

  double processWaveform(double ampDb) {
    if (ampDb <= silenceThreshold) {
      _previousHeight *= decayFactor;
      return _previousHeight < 0.5 ? 0.0 : _previousHeight;
    }

    final normalized = ((ampDb.clamp(-60.0, 0.0) + 60) / 60);

    _smoothedValue =
        (_smoothedValue * (1 - smoothingFactor)) +
        (normalized * smoothingFactor);

    final boosted = (_smoothedValue * 1.3).clamp(0.0, 1.0);

    final targetHeight = 32.h * boosted;

    final height = targetHeight > _previousHeight
        ? targetHeight
        : _previousHeight * decayFactor;

    _previousHeight = height;
    return height;
  }

  Future<void> pauseRecording() async {
    try {
      if (!isRecording || isRecordingPaused) return;
      emit(KycPromptLoading());
      await record.pause();
      amplitudeSub?.pause();
      isRecordingPaused = true;
      _recordTimer?.cancel();
      emit(KycPromptLoaded());
    } catch (e) {
      log('Error pausing recording: $e');
      emit(KycPromptError());
      rethrow;
    }
  }

  /// Resume a paused recording
  Future<void> resumeRecording() async {
    try {
      if (!isRecording || !isRecordingPaused) return;
      emit(KycPromptLoading());
      await record.resume();
      amplitudeSub?.resume();
      isRecordingPaused = false;
      _startTimer();
      emit(KycPromptLoaded());
    } catch (e) {
      log('Error resuming recording: $e');
      emit(KycPromptError());
      rethrow;
    }
  }

  /// Stop recording and finalize waveform data
  Future<void> stopRecording() async {
    try {
      emit(KycPromptLoading());
      final path = await record.stop();
      recordingPath = path ?? recordingPath;
      _stopTimer();
      amplitudeSub?.cancel();
      _captureWaveformData();
      promptToEdit = promptToEdit?.copyWith(
        promptAnswer: path,
        waveformData: recordedWaveformData,
        duration: recordedDuration,
      );
      isRecording = false;
      isRecordingPaused = false;
      isRecorded = true;
      isPlaying = false;
      log('Stopping recording...');
      emit(KycPromptLoaded());
    } catch (e) {
      log('Error stopping recording: $e');
      emit(KycPromptError());
      rethrow;
    }
  }

  /// Delete recorded audio and reset all audio state
  void deleteAudio() {
    emit(KycPromptLoading());
    _resetAudioState();
    emit(KycPromptLoaded());
  }

  // ==================== PRIVATE HELPERS ====================

  /// Start the recording timer
  void _startTimer() {
    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _recordingElapsed += const Duration(seconds: 1);
      final minutes = (_recordingElapsed.inSeconds ~/ 60).toString().padLeft(
        2,
        '0',
      );
      final seconds = (_recordingElapsed.inSeconds % 60).toString().padLeft(
        2,
        '0',
      );
      recordedDuration = '$minutes:$seconds';
      emit(KycPromptLoaded());
    });
  }

  /// Stop the recording timer
  void _stopTimer() {
    _recordTimer?.cancel();
  }

  /// Capture waveform data from the recorder controller
  void _captureWaveformData() {
    if (recordedWaveformData.length < 120) {
      final additionalSamples = 120 - recordedWaveformData.length;
      final firstValue = recordedWaveformData.isNotEmpty
          ? recordedWaveformData.first.clamp(1.0, double.infinity)
          : 1.0;

      recordedWaveformData.insertAll(
        0,
        List<double>.filled(additionalSamples, firstValue),
      );
    }

    // Update duration from timer
    final minutes = (_recordingElapsed.inSeconds ~/ 60).toString().padLeft(
      2,
      '0',
    );
    final seconds = (_recordingElapsed.inSeconds % 60).toString().padLeft(
      2,
      '0',
    );
    recordedDuration = '$minutes:$seconds';
  }

  /// Called when playback stops
  void _onPlaybackStopped() {
    isPlaying = false;
    emit(KycPromptLoaded());
  }

  /// Reset all audio-related state
  void _resetAudioState() {
    emit(KycPromptLoading());
    // Stop playback and recording
    record.stop();
    isPlaying = false;
    isRecording = false;
    isRecordingPaused = false;
    _stopTimer();
    _recordingElapsed = Duration.zero;

    // Delete audio file
    if (recordingPath != null) {
      try {
        final file = File(recordingPath!);
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        log('Error deleting audio file: $e');
      }
    }

    recordingPath = null;
    isRecorded = false;
    isPlaying = false;
    isRecording = false;
    isRecordingPaused = false;
    recordedWaveformData = [];
    recordedDuration = '00:00';
    emit(KycPromptLoaded());
  }

  // ==================== PROMPT MANAGEMENT ====================

  void showCreatePromptBottomSheet() {
    emit(KycPromptLoading());
    _showBottomSheet = true;
    emit(KycPromptLoaded());
  }

  void hideCreatePromptBottomSheet() {
    emit(KycPromptLoading());
    _showBottomSheet = false;
    emit(KycPromptLoaded());
  }

  bool isPromptSelected(String prompt) {
    return selectedPrompts.any(
      (e) => e.promptText?.makeSearchAble() == prompt.makeSearchAble(),
    );
  }

  bool canSelectMore() {
    return selectedPrompts.length < maxPrompts;
  }

  bool isMaxReached() {
    return selectedPrompts.length >= maxPrompts;
  }

  // get prompt answer
  AudioPromptData? getPromptAnswer(String prompt) {
    return selectedPrompts.firstWhereOrNull(
      (e) => e.promptText?.makeSearchAble() == prompt.makeSearchAble(),
    );
  }

  // ==================== SUBMIT CUSTOM PROMPT ====================

  /// Submit a custom prompt (text or audio)
  Future<void> submitCustomPrompt({
    required String promptTitle,
    required String type,
    required String promptAnswer,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      emit(KycPromptLoading());
      final usecase = Di().sl<CreateAccountUsecase>();

      final response = await usecase.customPrompt(
        promptTitle: promptTitle,
        type: type,
        promptAnswer: promptAnswer,
      );
      if (response is Map<String, dynamic>) {
        customPromptModel = CustomPromptModel.fromJson(response);
        log('✅ customPromptModel Model : $customPromptModel');
      }

      log('✅ Custom prompt submitted: $response');
      emit(KycPromptLoaded());
      onSuccess();
    } catch (e) {
      log('❌ Custom prompt error: $e');
      emit(KycPromptError());
      onError('Failed to submit prompt: $e');
    }
  }

  /// Submit audio prompt: upload file then submit with URL
  Future<void> submitAudioPrompt({
    required String promptTitle,
    required String audioPath,
    required VoidCallback onSuccess,
    required Function(String) onError,
    required bool isEditMode,
    String? id,
    required BuildContext context,
  }) async {
    try {
      emit(KycPromptLoading());
      final cubit = Di().sl<CreateAccountCubit>();

      await cubit.uploadMedia(filePath: audioPath);

      String audioUrl;
      if (cubit.mediaLinks.isNotEmpty) {
        audioUrl = cubit.mediaLinks.first;
      } else {
        throw Exception('No URL returned from upload');
      }

      if (audioUrl.isEmpty) {
        throw Exception('No URL returned from upload');
      }

      if (isEditMode) {
        await cubit.updatePrompt(
          id: id ?? "",
          promptTitle: promptTitle,
          promptAnswer: audioUrl,
          context: context,
        );
      } else {
        await cubit.customPrompts(
          promptTitle: promptTitle,
          type: 'audio',
          promptAnswer: audioUrl,
          context: context,
        );
      }

      await cubit.loadProfile();
      cubit.mediaLinks.clear();

      emit(KycPromptLoaded());
      onSuccess();
    } catch (e) {
      log('❌ Audio prompt error: $e');
      emit(KycPromptError());
      onError('Failed to submit audio prompt: $e');
    }
  }
}
