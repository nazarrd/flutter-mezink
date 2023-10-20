import '../models/user_model.dart';
import '../services/network_service.dart';
import '../utils/print_log.dart';

class UserRepository extends NetworkService {
  static Future<UserModel?> getAllUser({int page = 1, int perPage = 10}) async {
    try {
      final response = await NetworkService.dio().get(
        "/users",
        queryParameters: {'page': page, 'per_page': perPage},
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } catch (error) {
      printLog("UserRepository.getAllUser => $error");
    }
    return null;
  }

  static Future<int> deleteUser(int? id) async {
    try {
      final response = await NetworkService.dio().delete("/users/$id");
      return response.statusCode ?? 200;
    } catch (error) {
      printLog("UserRepository.getAllUser => $error");
    }
    return 500;
  }
}
