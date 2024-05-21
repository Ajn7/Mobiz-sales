class LoginModel {
  String? status;
  User? user;
  Authorisation? authorisation;

  LoginModel({this.status, this.user, this.authorisation});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    authorisation = json['authorisation'] != null
        ? new Authorisation.fromJson(json['authorisation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.authorisation != null) {
      data['authorisation'] = this.authorisation!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  Null? emailVerifiedAt;
  Null? isSuperAdmin;
  String? isShopAdmin;
  String? isStaff;
  int? departmentId;
  int? designationId;
  int? storeId;
  int? rolId;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.isSuperAdmin,
      this.isShopAdmin,
      this.isStaff,
      this.departmentId,
      this.designationId,
      this.storeId,
      this.rolId,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isSuperAdmin = json['is_super_admin'];
    isShopAdmin = json['is_shop_admin'];
    isStaff = json['is_staff'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    storeId = json['store_id'];
    rolId = json['rol_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['is_super_admin'] = this.isSuperAdmin;
    data['is_shop_admin'] = this.isShopAdmin;
    data['is_staff'] = this.isStaff;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['store_id'] = this.storeId;
    data['rol_id'] = this.rolId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Authorisation {
  String? token;
  String? type;

  Authorisation({this.token, this.type});

  Authorisation.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    return data;
  }
}
