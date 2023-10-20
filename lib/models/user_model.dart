// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

class UserModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserData>? data;
  Support? support;

  UserModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(UserData.fromJson(v));
      });
    }
    support =
        json['support'] != null ? Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (support != null) {
      data['support'] = support!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;
  String? grade;
  String? followers;
  String? engagement;
  String? tags;
  String? hashtags;
  Uint8List? tempImage;

  UserData({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.grade,
    this.followers,
    this.engagement,
    this.tags,
    this.hashtags,
    this.tempImage,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    grade = json['grade'];
    followers = json['followers'];
    engagement = json['engagement'];
    tags = json['tags'];
    hashtags = json['hashtags'];
    tempImage = json['tempImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    data['grade'] = grade;
    data['followers'] = followers;
    data['engagement'] = engagement;
    data['tags'] = tags;
    data['hashtags'] = hashtags;
    data['tempImage'] = tempImage;
    return data;
  }

  UserData copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? grade,
    String? followers,
    String? platform,
    String? engagement,
    String? tags,
    String? hashtags,
    Uint8List? tempImage,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      grade: grade ?? this.grade,
      followers: followers ?? this.followers,
      engagement: engagement ?? this.engagement,
      tags: tags ?? this.tags,
      hashtags: hashtags ?? this.hashtags,
      tempImage: tempImage ?? this.tempImage,
    );
  }
}

class Support {
  String? url;
  String? text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['text'] = text;
    return data;
  }
}
