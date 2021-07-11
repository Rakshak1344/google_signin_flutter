import 'package:client/Api/APIBase.dart';
import 'package:client/Api/APIConfig.dart';
import 'package:client/models/userResponseModels/userSuccessModel.dart';

class UserServices {
  APIBase _helper = APIBase();

  // Register
  Future<UserSuccessModel> registerUser(dynamic bodyParam) async {
    final response = await _helper.postRequest(API_USER_REGISTER, bodyParam);
    print(response);
    return UserSuccessModel.fromJson(response);
  }

  // Login
  

}
