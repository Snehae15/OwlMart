import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;

  const ProductEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
