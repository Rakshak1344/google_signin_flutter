class UserFailureModel {
  int? status;
  String? success;
  String? message;

  UserFailureModel({this.status, this.success, this.message});

  UserFailureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
  }
}
