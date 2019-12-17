

class LoginResponse {
  bool success;
  int userID;
  String message;

  LoginResponse({
    this.success = true,
    this.userID,
    this.message,
  });

  //todo this map will probably have different keys
  LoginResponse.fromMap(Map<String, dynamic> json) {
    this.success = json["success"];
    this.userID = json["userID"];
    this.message = json["message"];
  }
}