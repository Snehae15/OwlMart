import 'package:equatable/equatable.dart';

class WishlistEntity extends Equatable {
  final String id;

  const WishlistEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
