import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onestore_app/domain/entities/banner.dart';
import 'package:onestore_app/domain/usecases/banner/get_banners.dart';
import 'package:onestore_app/utils/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_event.dart';
part 'banner_state.dart';
part 'banner_bloc.freezed.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final GetBanners _getBanners;

  BannerBloc({required GetBanners getBanners})
      : _getBanners = getBanners,
        super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      try {
        final result = await _getBanners.execute();
        result.fold(
          (failure) => throw failure,
          (banners) => emit(_Loaded(banners)),
        );
      } on Failure catch (failure) {
        emit(_Error(failure.message));
      }
    });
  }
}
