import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/controllers/visit_profile_cubit/visit_profile_states.dart';
import 'package:social_app/models/user_model.dart';
import '../../../models/post_model.dart';


class VisitCubit extends Cubit<VisitStates>{
  VisitCubit() :super (VisitInitialState());

  static VisitCubit get(context) => BlocProvider.of(context);

  //Get user visit data
  UserModel? userVisitModel;
  Future getUserVisitData({required String userId}) async {
    emit(GetUserVisitLoadingState());
    //get method return -> Future<DocumentSnapShot>
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen((value) async {
      userVisitModel = null;
      userVisitModel = UserModel.fromJson(value.data());
      getUserVisitPosts(userId: userId);
      //userModel?.isEmailVerified =  await FirebaseAuth.instance.currentUser!.emailVerified;
      // emit(GetUserVisitSuccessState());
    });
  }

  //Get user visit posts
 // UserModel? userModel = SocialCubit().userModel;
  List<PostModel>? userVisitPosts =[];
  List<String> userVisitPostsIds = [];
  List<int> userVisitPostsLikes = [];
  Future getUserVisitPosts({required String userId}) async{
    emit(GetUserVisitPostsLoadingState());
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((value) async {
      userVisitPosts =[];
      for (var element in value.docs) {
        if(await element.reference.collection('likes').snapshots().isEmpty){
          userVisitPostsIds.add(element.id);
          if(element.data().containsValue(userId)) {
            userVisitPosts?.add(PostModel.fromJson(element.data()));
          }
        }
        else {
          element.reference.collection('likes').snapshots().listen((value) {
            userVisitPostsLikes.add(value.docs.length);
            userVisitPostsIds.add(element.id);
            if(element.data().containsValue(userId)) {
              userVisitPosts?.add(PostModel.fromJson(element.data()));
            }

          });
        }

      }
      emit(GetUserVisitPostsSuccessState());

    });
  }

  void removeUserVisitPosts() {
    userVisitPosts = null;
    emit(RemoveUserVisitPostsSuccessState());
  }
}