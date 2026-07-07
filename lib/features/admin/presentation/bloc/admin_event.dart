import 'package:equatable/equatable.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<Object?> get props => [];
}

class GetAdminDataEvent extends AdminEvent {
  const GetAdminDataEvent();
}
