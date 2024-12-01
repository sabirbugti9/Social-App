
class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? coverImage;
  String? bio;
  bool? isEmailVerified;
  int? noOfPosts;
 // List<PostModel>? userPosts;
  int? noOfFollowers;
  int? noOfFollowing;
  int? noOfFriends;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.coverImage,
    required this.bio,
    required this.isEmailVerified,
    required this.noOfPosts,
    //this.userPosts,
    required this.noOfFollowers,
    required this.noOfFollowing,
    required this.noOfFriends,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    email = json?['email'];
    phone = json?['phone'];
    uId = json?['uId'];
    image = json?['image'];
    coverImage = json?['coverImage'];
    bio = json?['bio'];
    isEmailVerified = json?['isEmailVerified'];
    noOfPosts = json?['noOfPosts'];
    // json?['userPosts'].forEach((element) {
    //   userPosts?.add(PostModel.fromJson(element));
    // });
    noOfFollowers = json?['noOfFollowers'];
    noOfFollowing = json?['noOfFollowing'];
    noOfFriends = json?['noOfFriends'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bio': bio,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
      'noOfPosts': noOfPosts,
      //'userPosts': userPosts,
      'noOfFollowers': noOfFollowers,
      'noOfFollowing': noOfFollowing,
      'noOfFriends': noOfFriends,
    };
  }
}
