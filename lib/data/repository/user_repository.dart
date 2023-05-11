import '../entity/user.dart';

abstract class UserRepository {
  Future<bool> createUser(User user);

  Future<bool> loginUser(User user);

  Future<bool> deleteUser(User user);

  Future<bool> updateUser(User user, String newUsername, String newPassword);
}
