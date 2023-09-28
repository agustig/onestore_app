part of 'banner_bloc.dart';

@freezed
class BannerEvent with _$BannerEvent {
  const factory BannerEvent.started() = _Started;
  const factory BannerEvent.getAll() = _GetAll;
}
