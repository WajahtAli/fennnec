import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/create_account_cubit.dart';
import 'package:fennac_app/pages/auth/presentation/bloc/cubit/login_cubit.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/kyc_gallery_action_buttons.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/kyc_gallery_header.dart';
import 'package:fennac_app/pages/kyc/presentation/widgets/kyc_gallery_instructions.dart';
import 'package:fennac_app/reusable_widgets/gallery_grid_widget.dart';
import 'package:fennac_app/reusable_widgets/media_picker_options.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/widgets/custom_sized_box.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../auth/presentation/bloc/state/create_account_state.dart';

@RoutePage()
class KycGalleryScreen extends StatefulWidget {
  final bool? isEditMode;
  const KycGalleryScreen({super.key, this.isEditMode = false});

  @override
  State<KycGalleryScreen> createState() => _KycGalleryScreenState();
}

class _KycGalleryScreenState extends State<KycGalleryScreen> {
  int? _selectedIndex;
  final _createAccountCubit = Di().sl<CreateAccountCubit>();
  final _imagePickerCubit = Di().sl<ImagePickerCubit>();
  final _loginCubit = Di().sl<LoginCubit>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initGallery();
  }

  Future<void> _initGallery() async {
    if (widget.isEditMode == true) {
      await _loginCubit.getSelfInfo();
    }
    await _prefillFromUserData();
  }

  void _setPrimaryMediaIndex(int index) {
    final mediaList = _imagePickerCubit.mediaList;
    if (index <= 0 || index >= mediaList.length) {
      if (mounted) {
        setState(
          () => _selectedIndex = index < mediaList.length ? index : null,
        );
      }
      return;
    }

    _imagePickerCubit.reorderMedia(index, 0);
    _syncMediaLinksWithMediaList();

    if (mounted) {
      setState(() => _selectedIndex = 0);
    }
  }

  Future<void> uploadAllMedia() async {
    final mediaList = _imagePickerCubit.mediaList;
    if (mediaList.isEmpty) return;

    final uploadTasks = mediaList
        .where((item) => !item.path.startsWith('http'))
        .map((item) => _uploadMedia(item.path))
        .toList();

    if (uploadTasks.isNotEmpty) {
      await Future.wait(uploadTasks);
    }
    _syncMediaLinksWithMediaList();
  }

  void _syncMediaLinksWithMediaList() {
    final links = _imagePickerCubit.mediaList.map((item) => item.path).toList();
    _createAccountCubit.mediaLinks = links;

    final user = _loginCubit.userData?.user;
    if (user != null && widget.isEditMode == true) {
      _loginCubit.updateUserFromProfileModel(
        user.copyWith(bestShorts: List<String>.from(links)),
      );
    }
  }

  Future<void> _uploadMedia(String filePath) async {
    try {
      final uploadedUrl = await _createAccountCubit.uploadMedia(filePath: filePath);
      if (uploadedUrl.isNotEmpty) {
        _updateMediaItemPath(filePath, uploadedUrl);
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: 'Upload failed: $e',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  void _updateMediaItemPath(String oldPath, String newUrl) {
    final currentList = _imagePickerCubit.mediaList;
    final index = currentList.indexWhere((item) => item.path == oldPath);

    if (index != -1) {
      final updatedList = List<MediaItem>.from(currentList);
      updatedList[index] = MediaItem(
        path: newUrl,
        type: currentList[index].type,
        id: currentList[index].id,
      );
      _imagePickerCubit.updateMediaList(updatedList);
    }
  }

  Future<void> _prefillFromUserData() async {
    final existing = _loginCubit.userData?.user?.bestShorts ?? [];
    if (existing.isEmpty) return;

    if (widget.isEditMode == true) {
      _createAccountCubit.mediaLinks = List<String>.from(existing);
    }

    final prefilled = existing
        .take(ImagePickerCubit().maxMediaItems)
        .toList()
        .asMap()
        .entries
        .map(
          (entry) => MediaItem(
            path: entry.value,
            type: MediaType.image,
            id: 'existing_${entry.key}_${entry.value.hashCode}',
          ),
        )
        .toList();

    _imagePickerCubit.updateMediaList(prefilled);
    if (prefilled.isNotEmpty && mounted) {
      setState(() => _selectedIndex = 0);
    }
  }

  Future<void> _handleContinue() async {
    setState(() => isLoading = true);
    _syncMediaLinksWithMediaList();
    await uploadAllMedia();

    if (widget.isEditMode == true) {
      await _createAccountCubit.updateProfile();
      setState(() => isLoading = false);
      if (mounted) AutoRouter.of(context).pop();
    } else {
      setState(() => isLoading = false);
      if (mounted) AutoRouter.of(context).push(const KycMatchRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLightTheme(context)
          ? Colors.white
          : const Color(0xFF1A1B2E),
      body: MovableBackground(
        backgroundType: MovableBackgroundType.medium,
        child: SafeArea(
          child: BlocConsumer<ImagePickerCubit, ImagePickerState>(
            bloc: _imagePickerCubit,
            listenWhen: (p, c) =>
                c.errorMessage != null && c.errorMessage != p.errorMessage,
            listener: (context, state) {
              Fluttertoast.showToast(
                msg: state.errorMessage!,
                backgroundColor: Colors.red,
              );
            },
            builder: (context, state) {
              final mediaList = state.mediaList ?? [];
              final displayIndex =
                  (widget.isEditMode == true &&
                      _selectedIndex != null &&
                      _selectedIndex! < mediaList.length)
                  ? _selectedIndex
                  : (widget.isEditMode == true && mediaList.isNotEmpty
                        ? 0
                        : null);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const KycGalleryHeader(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomSizedBox(height: 32),
                          GalleryGridWidget(
                            mediaList: mediaList,
                            onShowMediaPicker: (context, {containerIndex}) =>
                                MediaPickerOptions.show(
                                  context,
                                  containerIndex: containerIndex,
                                ),
                            isEditMode: widget.isEditMode == true,
                            selectedIndex: displayIndex,
                            onMediaTap: (index) {
                              if (widget.isEditMode == true) {
                                _setPrimaryMediaIndex(index);
                              }
                            },
                          ),
                          const CustomSizedBox(height: 24),
                          const KycGalleryInstructions(),
                          const CustomSizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<CreateAccountCubit, CreateAccountState>(
        bloc: _createAccountCubit,
        builder: (context, state) => KycGalleryActionButtons(
          isEditMode: widget.isEditMode == true,
          isLoading: isLoading,
          onSkip: () => AutoRouter.of(context).push(const KycMatchRoute()),
          onContinue: _handleContinue,
        ),
      ),
    );
  }
}
