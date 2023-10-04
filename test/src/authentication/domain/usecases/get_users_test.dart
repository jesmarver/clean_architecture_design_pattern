// What class depends on
// Answer -> AuthenticationRepository
// How can we create a fake version of the dependency
// Answer -> Use Mocktail
// How do we control what our dependencies do
// Answer -> Using the Mocktils's APIs

import 'package:clean_architecture_design_pattern/src/authentication/domain/entities/user.dart';
import 'package:clean_architecture_design_pattern/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture_design_pattern/src/authentication/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  const tResponse = [User.empty()];

  test(
      'should call [AuthenticationRepository.getUsers] and return [List<User>]',
      () async {
    // Arrange
    when(
      () => repository.getUsers(),
    ).thenAnswer(
      (_) async => Right(tResponse),
    );

    // Act

    final result = await usecase();

    //Assert

    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(
      () => repository.getUsers(),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
