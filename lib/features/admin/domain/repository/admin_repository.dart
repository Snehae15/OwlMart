import '../entities/admin_entity.dart';

abstract class AdminRepository {
  Future<AdminEntity> getAdminData();
}
