import 'package:auto_route/auto_route.dart';
import 'package:fennac_app/pages/find_group/presentation/bloc/state/find_group_state.dart';
import 'package:fennac_app/widgets/movable_background.dart';
import 'package:fennac_app/bloc/cubit/imagepicker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../app/constants/app_enums.dart';

import '../../../../core/di_container.dart';
import '../bloc/cubit/find_group_cubit.dart';
import '../widget/find_group_header.dart';
import '../widget/group_preview_dialog.dart';
import '../widget/member_preview_dialog.dart';
import '../widget/scanner_view.dart';

@RoutePage()
class FindGroupScreen extends StatefulWidget {
  final String? qrCode;
  final FindGroupScreenType? findGroupScreenType;
  final bool isFromCreateGroup;

  const FindGroupScreen({
    super.key,
    this.qrCode,
    this.findGroupScreenType,
    this.isFromCreateGroup = false,
  });

  @override
  State<FindGroupScreen> createState() => _FindGroupScreenState();
}

class _FindGroupScreenState extends State<FindGroupScreen> {
  late final ImagePickerCubit _pickerCubit;
  final FindGroupCubit _findGroupCubit = Di().sl<FindGroupCubit>();
  final MobileScannerController _controller = MobileScannerController();

  bool _dialogShown = false;
  bool _isScanLocked = false;
  bool isUserQr = false;

  @override
  void initState() {
    super.initState();

    _pickerCubit = ImagePickerCubit();

    final qrCode = widget.qrCode?.trim();

    if (qrCode != null && qrCode.isNotEmpty) {
      isUserQr = qrCode.startsWith('USR-');

      Future.microtask(() async {
        await _controller.stop();
        _isScanLocked = true;
        if (isUserQr) {
          _findGroupCubit.fetchMemberByQr(qrCode);
        } else {
          _findGroupCubit.fetchGroupByQr(qrCode);
        }
      });
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
        if (isUserQr) {
          return MemberPreviewDialog(
            findGroupCubit: _findGroupCubit,
            widgetQrCode: widget.qrCode,
            isFromCreateGroup: widget.isFromCreateGroup,
          );
        } else {
          return GroupPreviewDialog(
            findGroupCubit: _findGroupCubit,
            widgetQrCode: widget.qrCode,
          );
        }
      },
    ).then((_) {
      if (!mounted) return;

      _dialogShown = false;
      _isScanLocked = false;
      _controller.start();
    });
  }

  Future<void> _handleScan(BarcodeCapture capture) async {
    if (_isScanLocked || _dialogShown) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue?.trim();
    if (code == null || code.isEmpty) return;

    _isScanLocked = true;

    await _controller.stop();

    isUserQr = code.startsWith('USR-');

    if (isUserQr) {
      _findGroupCubit.fetchMemberByQr(code);
    } else {
      _findGroupCubit.fetchGroupByQr(code);
    }
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    _pickerCubit.close();
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FindGroupHeader(
                    findGroupScreenType:
                        widget.findGroupScreenType ??
                        FindGroupScreenType.createGroup,
                  ),

                  const SizedBox(height: 18),

                  ScannerView(controller: _controller, onDetect: _handleScan),

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
