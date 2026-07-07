import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/admin_order_entity.dart';
import '../repository/admin_repository.dart';

class GetAdminOrdersUseCase implements UseCase<List<AdminOrderEntity>, NoParams> {
  final AdminRepository repository;

  const GetAdminOrdersUseCase({required this.repository});

  @override
  Future<List<AdminOrderEntity>> call(NoParams params) async {
    return repository.getOrders();
  }
}
