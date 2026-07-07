import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  final String id;

  const SearchEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
