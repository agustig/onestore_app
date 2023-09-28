import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final int id;
  final String name;
  final String bannerUrl;
  final bool isEnabled;

  const Banner({
    required this.id,
    required this.name,
    required this.bannerUrl,
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [id, name, bannerUrl, isEnabled];
}
