import 'package:equatable/equatable.dart';

class AdminEntity extends Equatable {
  final String id;

  const AdminEntity({required this.id});

  @override
  List<Object?> get props => [id];
}
