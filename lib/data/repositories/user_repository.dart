import 'package:api_integrations/data/model/user_model.dart';
import 'package:api_integrations/data/servicecs/api_services.dart';

class UserRepository {
  final ApiServicesUser apiServicesUser;
  UserRepository(this.apiServicesUser);
  Future<List<UserModel>> getUsers() async {
    final data = await apiServicesUser.fetchUsers();
    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}
