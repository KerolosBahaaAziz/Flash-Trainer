import 'package:flash_trainer_app_bloc/app/data/models/users.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const pod = Pods(
    wrongTouch: '1',
    rightTouch: '9',
    averageTime: '0.42',
    podName: 'Pod A',
    activePods: '3',
  );

  const training = TrainingModel(
    trainingTime: '10:30',
    trainingDay: '2026-11-17',
    podsUsedCount: 3,
    pods: [pod],
  );

  const user = Users(userName: 'tester', training: [training]);

  group('Users JSON', () {
    test('survives a toJson -> fromJson round trip', () {
      expect(Users.fromJson(user.toJson()), user);
    });

    test('serializes nested training and pods', () {
      final json = user.toJson();

      expect(json['userName'], 'tester');
      final trainingJson = (json['training'] as List).single as Map;
      expect(trainingJson['podsUsedCount'], 3);
      expect((trainingJson['pods'] as List).single['podName'], 'Pod A');
    });

    test('handles a user with no training history', () {
      const empty = Users(userName: 'new', training: []);
      expect(Users.fromJson(empty.toJson()), empty);
    });
  });

  test('copyWith only changes the given field', () {
    final renamed = user.copyWith(userName: 'renamed');
    expect(renamed.userName, 'renamed');
    expect(renamed.training, user.training);
  });
}
