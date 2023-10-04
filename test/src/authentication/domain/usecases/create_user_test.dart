// What class depends on
// Answer -> AuthenticationRepository
// How can we create a fake version of the dependency
// Answer -> Use Mocktail
// How do we control what our dependencies do
// Answer -> Using the Mocktils's APIs

import 'package:clean_architecture_design_pattern/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_architecture_design_pattern/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUpAll(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();
  test(
    'should call the [AuthenticationRepository.createUser]',
    () async {
      // Arrange
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
