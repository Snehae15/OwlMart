import 'package:owlmart/core/usecase/usecase.dart';
import '../entities/search_entity.dart';
import '../repository/search_repository.dart';

class GetSearchUseCase implements UseCase<SearchEntity, NoParams> {
  final SearchRepository repository;

  const GetSearchUseCase({required this.repository});

  @override
  Future<SearchEntity> call(NoParams params) async {
    return repository.getSearchData();
  }
}
