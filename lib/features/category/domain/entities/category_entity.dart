import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;

  const CategoryEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
