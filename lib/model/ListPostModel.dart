import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ListPostModel {
  @JsonKey(name: 'sId')
  String? sId;
  @JsonKey(name: 'PostTitle')
  String? postTitle;
  @JsonKey(name: 'PostDescription')
  String? postDescription;
  @JsonKey(name: 'PostLink')
  String? postLink;
  @JsonKey(name: 'PostImage')
  String? postImage;
  @JsonKey(name: 'PostMetaTitle')
  String? postMetaTitle;
  @JsonKey(name: 'PostMetaDescription')
  String? postMetaDescription;
  @JsonKey(name: 'PostMetaKeyword')
  String? postMetaKeyword;
  @JsonKey(name: 'PostTag')
  String? postTag;
  @JsonKey(name: 'PostContent')
  String? postContent;
  @JsonKey(name: 'PostStatus')
  String? postStatus;
  @JsonKey(name: 'PostSortOrder')
  String? postSortOrder;
  @JsonKey(name: 'PostTotalView')
  String? postTotalView;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: '__v')
  int? iV;

  ListPostModel(
      {this.sId,
      this.postTitle,
      this.postDescription,
      this.postLink,
      this.postImage,
      this.postMetaTitle,
      this.postMetaDescription,
      this.postMetaKeyword,
      this.postTag,
      this.postContent,
      this.postStatus,
      this.postSortOrder,
      this.postTotalView,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ListPostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    postTitle = json['PostTitle'];
    postDescription = json['PostDescription'];
    postLink = json['PostLink'];
    postImage = json['PostImage'];
    postMetaTitle = json['PostMetaTitle'];
    postMetaDescription = json['PostMetaDescription'];
    postMetaKeyword = json['PostMetaKeyword'];
    postTag = json['PostTag'];
    postContent = json['PostContent'];
    postStatus = json['PostStatus'];
    postSortOrder = json['PostSortOrder'];
    postTotalView = json['PostTotalView'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['PostTitle'] = this.postTitle;
    data['PostDescription'] = this.postDescription;
    data['PostLink'] = this.postLink;
    data['PostImage'] = this.postImage;
    data['PostMetaTitle'] = this.postMetaTitle;
    data['PostMetaDescription'] = this.postMetaDescription;
    data['PostMetaKeyword'] = this.postMetaKeyword;
    data['PostTag'] = this.postTag;
    data['PostContent'] = this.postContent;
    data['PostStatus'] = this.postStatus;
    data['PostSortOrder'] = this.postSortOrder;
    data['PostTotalView'] = this.postTotalView;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}