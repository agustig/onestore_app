import 'package:equatable/equatable.dart';

class Collection<T extends dynamic> extends Equatable {
  final int collectionNumber;
  final List<T> collections;
  final int totalCollections;

  const Collection({
    required this.collectionNumber,
    required this.collections,
    required this.totalCollections,
  });

  @override
  List<Object?> get props => [collectionNumber, collections, totalCollections];
}
