class ImageNET {
  var id;
  String? url;
  bool ?isDefault;

  ImageNET({this.id, this.url, this.isDefault});

  ImageNET.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['isDefault'] = this.isDefault;
    return data;
  }
}