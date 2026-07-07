import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/home_entity.dart';
import '../repository/home_repository.dart';

class GetHomeUseCase implements UseCase<HomeEntity, NoParams> {
  final HomeRepository repository;

  const GetHomeUseCase({required this.repository});

  @override
  Future<HomeEntity> call(NoParams params) async {
    return repository.getHomeData();
  }
}
