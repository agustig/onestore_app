import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onestore_app/domain/entities/user.dart';
import 'package:onestore_app/domain/usecases/profile/get_profile.dart';
import 'package:onestore_app/utils/failure.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile _getProfile;

  ProfileBloc(GetProfile getProfile)
      : _getProfile = getProfile,
        super(const _Initial()) {
    on<_GetProfile>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await _getProfile.execute(authToken: event.authToken);
        result.fold(
          (failure) => throw failure,
          (user) => emit(_Loaded(user)),
        );
      } on Failure catch (failure) {
        emit(_Error(failure.message));
      }
    });
  }
}
