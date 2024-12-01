abstract class SocialStates{}

class SocialInitialState extends SocialStates{}
class SocialChangeBottomNavState extends SocialStates{}

class SocialSetModeState extends SocialStates{}
class SocialChangeModeState extends SocialStates{}
//Get user data
class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  late final  String error;
  SocialGetUserErrorState(this.error);
}

//Get user visit data
class SocialGetUserVisitLoadingState extends SocialStates{}

class SocialGetUserVisitSuccessState extends SocialStates{}

class SocialGetUserVisitErrorState extends SocialStates{
  late final  String error;
  SocialGetUserVisitErrorState(this.error);
}
//Get all users
class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{
  late final  String error;
  SocialGetAllUsersErrorState(this.error);
}


//Add post
class SocialAddPostState extends SocialStates{}
//Get profile image
class SocialGetProfileImageSuccessState extends SocialStates{}

class SocialGetProfileImageErrorState extends SocialStates{}
//Get cover image
class SocialGetCoverImageSuccessState extends SocialStates{}

class SocialGetCoverImageErrorState extends SocialStates{}
//upload profile image
class SocialUploadProfileImageSuccessState extends SocialStates{}

class SocialUploadProfileImageErrorState extends SocialStates{}
//upload cover image
class SocialUploadCoverImageSuccessState extends SocialStates{}

class SocialUploadCoverImageErrorState extends SocialStates{}
//update user data
class SocialUpdateUserDataLoadingState extends SocialStates{}

class SocialUpdateUserDataSuccessState extends SocialStates{}

class SocialUpdateUserDataErrorState extends SocialStates{}
//Get post image
class SocialGetPostImageSuccessState extends SocialStates{}

class SocialGetPostImageErrorState extends SocialStates{}
//upload post image
class SocialUploadPostImageSuccessState extends SocialStates{}

class SocialUploadPostImageErrorState extends SocialStates{}
//remove post image
class SocialRemovePostImageSuccessState extends SocialStates{}
//create post
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}
//Get Posts
class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{}

//Update Posts
class SocialUpdatePostLoadingState extends SocialStates{}

class SocialUpdatePostSuccessState extends SocialStates{}

class SocialUpdatePostErrorState extends SocialStates{}

//Delete Posts
class SocialDeletePostsLoadingState extends SocialStates{}

class SocialDeletePostsSuccessState extends SocialStates{}

class SocialDeletePostsErrorState extends SocialStates{}

//Get user visit Posts
class SocialGetUserVisitPostsLoadingState extends SocialStates{}

class SocialGetUserVisitPostsSuccessState extends SocialStates{}

class SocialGetUserVisitPostsErrorState extends SocialStates{}
// remove user visit posts
class SocialRemoveUserVisitPostsSuccessState extends SocialStates{}



// like post
class SocialPostLikeSuccessState extends SocialStates{}

class SocialPostLikeErrorState extends SocialStates{}

//disLike post
class SocialDisPostLikeSuccessState extends SocialStates{}

class SocialDisPostLikeErrorState extends SocialStates{}
//like button change color
// class SocialChangePostLikeColorSuccessState extends SocialStates{}
//
// class SocialChangePostLikeColorErrorState extends SocialStates{}

//log out
class SocialLogOutSuccessState extends SocialStates{}

class SocialLogOutErrorState extends SocialStates{}

//chat
//send a message
class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}
//get message image
class SocialGetMessageImageSuccessState extends SocialStates{}

class SocialGetMessageImageErrorState extends SocialStates{}
//upload message image
class SocialUploadMessageImageSuccessState extends SocialStates{}

class SocialUploadMessageImageErrorState extends SocialStates{}
//get all messages
class SocialGetMessagesSuccessState extends SocialStates{}

class SocialGetMessagesErrorState extends SocialStates{}
//delete message
class SocialDeleteMessageSuccessState extends SocialStates{}

class SocialDeleteMessageErrorState extends SocialStates{}