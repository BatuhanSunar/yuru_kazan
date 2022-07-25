class UserInfo {
  int? userId;
  DateTime? sure;
  double? mesafe;

  UserInfo({this.userId, this.sure, this.mesafe});

  UserInfo.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    sure = json['sure'];
    mesafe = json['mesafe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['sure'] = this.sure;
    data['mesafe'] = this.mesafe;
    return data;
  }
}
