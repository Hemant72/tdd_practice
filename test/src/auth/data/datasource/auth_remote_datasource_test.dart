import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_practice/core/error/exception.dart';
import 'package:tdd_practice/core/utils/constants.dart';
import 'package:tdd_practice/src/auth/data/datasource/auth_remote_datasource.dart';

class MockClient extends Mock implements Dio {}

void main() {
  late Dio client;
  late AuthRemoteDatasourceImpl datasource;

  setUp(() {
    client = MockClient();
    datasource = AuthRemoteDatasourceImpl(client);
    registerFallbackValue(Uri());
  });

  group("Create User", () {
    test('Should complete the call when the status code is 200 and 201',
        () async {
      // Arrange
      when(() => client.post(any(), data: any(named: "data")))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(
                  path:
                      '$kBaseUrl/user', // Use relative path, ensure this matches the endpoint
                  method: 'POST', // Specify the HTTP method
                ),
                statusMessage: "User created successfully",
                statusCode: 201,
              ));
      // Act
      final methodCall = datasource.createUser(
        name: "name",
        avatar: "avatar",
        createdAt: "createdAt",
      );
      // Assert
      expect(methodCall, completes);
      verify(() => client.post(
            '$kBaseUrl/user',
            data: {
              'name': "name",
              'avatar': "avatar",
              'createdAt': "createdAt",
            },
          )).called(1);
      verifyNoMoreInteractions(client);
    });

    test(
        "Should throw an [Server Excpetion] when the status code is not 200 and 201",
        () async {
      //arange
      when(() => client.post(any(), data: any(named: "data")))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(
                  path:
                      '$kBaseUrl/user', // Use relative path, ensure this matches the endpoint
                  method: 'POST', // Specify the HTTP method
                ),
                statusMessage: "error message",
                statusCode: 400,
              ));

      // act

      final methodCall = datasource.createUser(
        name: "name",
        avatar: "avatar",
        createdAt: "createdAt",
      );
      //assert
      expect(
          methodCall,
          throwsA(const ServerException(
              message: "error message", statusCode: 400)));
      verify(() => client.post(
            '$kBaseUrl/user',
            data: {
              'name': "name",
              'avatar': "avatar",
              'createdAt': "createdAt",
            },
          )).called(1);
      verifyNoMoreInteractions(client);
    });
  });

  // group("get User", () {
  //   test('Should complete the call when the status code is 200 and 201',
  //       () async {
  //     // Arrange
  //     when(() => client.get(any())).thenAnswer((_) async => Response(
  //           requestOptions: RequestOptions(
  //             path: '$kBaseUrl/user', // Replace with your URL or path
  //             method: 'GET', // Specify the HTTP method
  //           ),
  //           statusMessage: "User get successfully",
  //           statusCode: 201,
  //         ));
  //     // Act
  //     // final result = await client.get(path);
  //     // Assert
  //     // expect(result, completes);
  //     verify(() => client.get("$kBaseUrl/user")).called(1);
  //     verifyNoMoreInteractions(client);
  //   });
  // });
}
