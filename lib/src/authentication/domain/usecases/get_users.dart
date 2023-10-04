import 'package:clean_architecture_design_pattern/core/usecase/usecase.dart';
import 'package:clean_architecture_design_pattern/core/utils/typedef.dart';
import 'package:clean_architecture_design_pattern/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_design_pattern/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
