import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onestore_app/presentation/bloc/banner/banner_bloc.dart';
import 'package:onestore_app/utils/failure.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../mock_helper.dart';

void main() {
  late BannerBloc bannerBloc;
  late MockGetBanners mockUseCase;

  setUp(() {
    mockUseCase = MockGetBanners();
    bannerBloc = BannerBloc(getBanners: mockUseCase);
  });

  test(
    'Initial setup should be BannerState.initial()',
    () => expect(bannerBloc.state, const BannerState.initial()),
  );

  group('GetAll() banner event:', () {
    const tBanners = [testBanner];
    blocTest(
      'should return [loading, loaded] when banners is loaded successfully',
      build: () {
        when(() => mockUseCase.execute())
            .thenAnswer((_) async => right(tBanners));
        return bannerBloc;
      },
      act: (bloc) => bloc.add(const BannerEvent.getAll()),
      expect: () => [
        const BannerState.loading(),
        const BannerState.loaded(tBanners),
      ],
      verify: (_) => [mockUseCase.execute()],
    );

    blocTest(
      'should return [loading, loaded] when category loading has get error',
      build: () {
        when(() => mockUseCase.execute()).thenAnswer((_) async =>
            const Left(ConnectionFailure('Failed connect to the Network')));
        return bannerBloc;
      },
      act: (bloc) => bloc.add(const BannerEvent.getAll()),
      expect: () => [
        const BannerState.loading(),
        const BannerState.error('Failed connect to the Network'),
      ],
      verify: (_) => [mockUseCase.execute()],
    );
  });
}
