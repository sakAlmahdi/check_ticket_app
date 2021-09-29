class Login {
 late String _grantType;
 late String _password;
 late String _username;

  Login({required String grantType, required String password, required String username}) {
    this._grantType = grantType;
    this._password = password;
    this._username = username;
  }

  String get grantType => _grantType;
  set grantType(String grantType) => _grantType = grantType;
  String get password => _password;
  set password(String password) => _password = password;
  String get username => _username;
  set username(String username) => _username = username;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grant_type'] = this._grantType;
    data['password'] = this._password;
    data['username'] = this._username;
    return data;
  }
}
