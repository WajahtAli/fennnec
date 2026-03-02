import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecase/update_profile_usecase.dart';

part '../state/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  UpdateProfileCubit(this.updateProfileUseCase) : super(UpdateProfileState());
}
