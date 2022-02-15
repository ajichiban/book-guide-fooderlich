class Post {
  late String profileImageUrl;
  late String comment;
  late String foodPictureUrl;
  late String timestamp;

  Post(
      {required this.profileImageUrl,
      required this.comment,
      required this.foodPictureUrl,
      required this.timestamp});

  Post.fromJson(Map<String, dynamic> json) {
    profileImageUrl = json['profileImageUrl'];
    comment = json['comment'];
    foodPictureUrl = json['foodPictureUrl'];
    timestamp = json['timestamp'];
  }
}
