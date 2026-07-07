import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/admin_dashboard_stats.dart';
import '../repository/admin_repository.dart';

class GetAdminDashboardStatsUseCase implements UseCase<AdminDashboardStats, NoParams> {
  final AdminRepository repository;

  const GetAdminDashboardStatsUseCase({required this.repository});

  @override
  Future<AdminDashboardStats> call(NoParams params) async {
    return repository.getDashboardStats();
  }
}
