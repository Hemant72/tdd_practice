import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_practice/src/auth/data/model/user_model.dart';
import 'package:tdd_practice/src/auth/domain/entities/user.dart';

import '../../../../fixtures/fixture.dart';

void main() {
  const tModel = UserModel.empty();
  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as Map<String, dynamic>;

  test('should be the subclass of the [User]', () {
    expect(tModel, isA<User>());
  });

  group("fromMap", () {
    test("should return a valid [UserModel]", () {
      // act
      final result = UserModel.fromMap(tMap);
      // assert
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    test("should return a valid [UserModel]", () {
      // act
      final result = UserModel.fromJson(tJson);
      // assert
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("should return a valid [UserModel]", () {
      // act
      final result = tModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("should return a valid [UserModel]", () {
      // act
      final result = tModel.toJson();
      final tJson1 = jsonEncode({
        "id": "empty.id",
        "name": "empty.name",
        "createdAt": "empty.createdAt",
        "avatar": "empty.avatar"
      });
      // assert
      expect(result, tJson1);
    });
  });

  group("copyWith", () {
    test("should return a valid [UserModel]", () {
      // act
      final result = tModel.copyWith(name: "test");

      // assert
      expect(result.name, equals("test"));
      
    });
  });
}
