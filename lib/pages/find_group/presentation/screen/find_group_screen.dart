import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/app/constants/media_query_constants.dart';
import 'package:fennac_app/app/theme/text_styles.dart';
import 'package:fennac_app/core/di_container.dart';
import 'package:fennac_app/pages/dashboard/presentation/bloc/cubit/dashboard_cubit.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/cubit/find_group_cubit.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/state/find_group_state.dart';
import 'package:fennac_app/pages/home/presentation/screen/home_screen.dart';
import 'package:fennac_app/reusable_widgets/custom_app_bar.dart';
import 'package:fennac_app/reusable_widgets/group_card.dart';
import 'package:fennac_app/routes/routes_imports.gr.dart';
import 'package:fennac_app/skeletons/group_card_skeleton.dart';
import 'package:fennac_app/utils/validators.dart';
import 'package:fennac_app/widgets/custom_elevated_button.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:lottie/lottie.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:fennac_app/bloc/state/imagepicker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:fennac_app/generated/assets.gen.dart';

@RoutePage()
class FindGroupScreen extends StatefulWidget {
  final String? qrCode;
  const FindGroupScreen({super.key, this.qrCode});

  @override
  State<FindGroupScreen> createState() => _FindGroupScreenState();
}

class _FindGroupScreenState extends State<FindGroupScreen>
    with WidgetsBindingObserver {
  late final ImagePickerCubit _pickerCubit;
  final FindGroupCubit _findGroupCubit = Di().sl<FindGroupCubit>();
  final MobileScannerController _controller = MobileScannerController();
  bool _dialogShown = false;
  bool _isScanProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pickerCubit = ImagePickerCubit();
    final qrCode = widget.qrCode?.trim();
    if (qrCode != null && qrCode.isNotEmpty) {
      Future.microtask(() => _findGroupCubit.fetchGroupByQr(qrCode));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    if (state == AppLifecycleState.resumed) {
      _controller.start();
      return;
    }

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _controller.stop();
    }
  }

  void _showDialogOnce() {
    if (_dialogShown || !mounted) return;
    _dialogShown = true;
    _showLandingDialog();
  }

  void _showLandingDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'GroupDialog',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: getWidth(context),
                // height: 504,
                height: 304,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    decoration: BoxDecoration(
                      color: isLightTheme(context)
                          ? Colors.white
                          : const Color(0xFF0B0B0B),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: isLightTheme(context)
                              ? Colors.black.withValues(alpha: 0.15)
                              : const Color(0xFF5F00DB),
                          blurRadius: 50,
                          spreadRadius: 0,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<FindGroupCubit, FindGroupState>(
                          bloc: _findGroupCubit,
                          builder: (context, state) {
                            if (state is FindGroupLoading) {
                              return const GroupCardSkeleton();
                            }

                            final apiAvatars =
                                _findGroupCubit.myGroupModel?.data?.members
                                    ?.map((member) => member.image)
                                    .toList() ??
                                [];
                            final avatarPaths = apiAvatars.isNotEmpty
                                ? apiAvatars
                                : [
                                    Assets.dummy.a1.path,
                                    Assets.dummy.a2.path,
                                    Assets.dummy.a3.path,
                                    Assets.dummy.a4.path,
                                    Assets.dummy.a5.path,
                                  ];

                            return GroupCard(
                              isShowInfoIcon: false,
                              height: 166,
                              backgroundColor: isLightTheme(context)
                                  ? Colors.white
                                  : Colors.black.withValues(alpha: 0.2),
                              title:
                                  _findGroupCubit
                                      .myGroupModel
                                      ?.data
                                      ?.titleMembers ??
                                  'Your Group',
                              subtitle:
                                  _findGroupCubit.myGroupModel?.data?.bio ??
                                  'Group details',
                              avatarPaths: validateStringList(avatarPaths),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder(
                          bloc: _findGroupCubit,
                          builder: (context, state) {
                            return SizedBox(
                              width: 300,
                              child: CustomElevatedButton(
                                text: 'Join Group',
                                isLoading: _findGroupCubit.isJoining,
                                icon: _findGroupCubit.isJoining
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Lottie.asset(
                                          Assets.animations.loadingSpinner,
                                        ),
                                      )
                                    : null,
                                onTap: _findGroupCubit.isJoining
                                    ? () {}
                                    : () async {
                                        final qrCode =
                                            _findGroupCubit.currentQrCode ??
                                            widget.qrCode;
                                        if (qrCode == null || qrCode.isEmpty) {
                                          return;
                                        }
                                        final success = await _findGroupCubit
                                            .joinGroupByQr(qrCode);
                                        if (success && mounted) {
                                          Di().sl<DashboardCubit>().changePage(
                                            0,
                                            HomeScreen(),
                                          );
                                          AutoRouter.of(
                                            context,
                                          ).push(const DashboardRoute());
                                        } else {
                                          if (mounted) {
                                            AutoRouter.of(context).pop();
                                          }
                                        }
                                      },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _pickerCubit.close();
    _dialogShown = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImagePickerCubit>.value(
      value: _pickerCubit,
      child: BlocListener<FindGroupCubit, FindGroupState>(
        bloc: _findGroupCubit,
        listener: (context, state) {
          if (state is! FindGroupLoading && state is! FindGroupInitial) {
            _showDialogOnce();
          }
        },
        child: Scaffold(
          body: MovableBackground(
            backgroundType: MovableBackgroundType.dark,

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomAppBar(title: 'Find a Group'),
                  const SizedBox(height: 8),
                  Text(
                    'Quickly connect with your friends by scanning their\ngroup\'s QR code.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body(context),
                  ),
                  const SizedBox(height: 18),
                  Flexible(
                    child: Container(
                      height: 600,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            MobileScanner(
                              controller: _controller,
                              onDetect: (capture) {
                                if (_isScanProcessing || _dialogShown) {
                                  return;
                                }

                                final List<Barcode> barcodes = capture.barcodes;
                                if (barcodes.isEmpty) {
                                  return;
                                }

                                final String? code = barcodes.first.rawValue
                                    ?.trim();
                                if (code == null || code.isEmpty) {
                                  return;
                                }

                                _isScanProcessing = true;
                                _controller.stop();
                                _findGroupCubit.fetchGroupByQr(code);
                              },
                            ),

                            BlocBuilder<ImagePickerCubit, ImagePickerState>(
                              builder: (context, state) {
                                final media = state.mediaList;
                                if (media != null && media.isNotEmpty) {
                                  final path = media.last.path;
                                  return Image.file(
                                    File(path),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Looking for QR Code...',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 22),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
