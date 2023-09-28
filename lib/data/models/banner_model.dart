import 'package:equatable/equatable.dart';
import 'package:flutter_store_fic7/domain/entities/banner.dart';

class BannerModel extends Equatable {
  final int id;
  final String name;
  final String bannerUrl;
  final bool isEnabled;

  const BannerModel({
    required this.id,
    required this.name,
    required this.bannerUrl,
    required this.isEnabled,
  });

  @override
  List<Object?> get props => [id, name, bannerUrl, isEnabled];

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'],
      name: map['name'],
      bannerUrl: map['banner_url'],
      isEnabled: map['is_enabled'],
    );
  }

  Banner toEntity() {
    return Banner(
      id: id,
      name: name,
      bannerUrl: bannerUrl,
      isEnabled: isEnabled,
    );
  }
}
