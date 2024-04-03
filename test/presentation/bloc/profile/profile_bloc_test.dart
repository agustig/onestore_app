import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/presentation/bloc/profile/profile_bloc.dart';
import 'package:onestore_app/utils/failure.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late ProfileBloc profileBloc;
  late MockGetProfile mockUseCase;

  setUp(() {
    mockUseCase = MockGetProfile();
    profileBloc = ProfileBloc(mockUseCase);
  });

  test(
    'Initial setup should be ProfileState.initial()',
    () => expect(profileBloc.state, const ProfileState.initial()),
  );
  final tAuthToken = testAuthModel.token;

  group('GetProfile() event:', () {
    const tUser = testUser;

    blocTest(
      'should return [loading, loaded] when banners is loaded successfully',
      build: () {
        when(() => mockUseCase.execute(authToken: tAuthToken))
            .thenAnswer((_) async => right(tUser));
        return profileBloc;
      },
      act: (bloc) => bloc.add(ProfileEvent.getProfile(tAuthToken)),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.loaded(tUser),
      ],
      verify: (_) => [mockUseCase.execute(authToken: tAuthToken)],
    );

    blocTest(
      'should return [loading, loaded] when category loading has get error',
      build: () {
        when(() => mockUseCase.execute(authToken: tAuthToken)).thenAnswer(
            (_) async =>
                const Left(ConnectionFailure('Failed connect to the Network')));
        return profileBloc;
      },
      act: (bloc) => bloc.add(ProfileEvent.getProfile(tAuthToken)),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.error('Failed connect to the Network'),
      ],
      verify: (_) => [mockUseCase.execute(authToken: tAuthToken)],
    );
  });
}
