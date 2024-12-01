import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/core/controllers/register_bloc/register_states.dart';
import 'package:social_app/models/user_model.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  bool isCheckPassword = true;
  IconData icon = Icons.visibility_outlined;
  IconData confirmIcon = Icons.visibility_outlined;

  //method to register user by firebase Auth
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        usId: value.user!.uid,
        isEmailVerified: false,
      );
      //emit(SocialRegisterSuccessState());
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  // create account with google method
  continueWithGoogle() async{
    //start of sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // finally, sign in
    return  FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      userCreate(
        name: value.user!.displayName!,
        email: value.user!.email!,
        phone: '+01255485646465',
        usId: value.user!.uid,
        isEmailVerified: false,
      );
    });
  }

  // create account with facebook method
  continueInWithFacebook() async{
    //start of sign in process
    final FacebookLogin facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin.logIn(customPermissions: ['email']);
    final accessToken = result.accessToken?.token;
    //check login result
    if(result.status == FacebookLoginStatus.success){
      //create a new credential for user
      final faceCredential = FacebookAuthProvider.credential(accessToken!);
      // finally, sign in
      FirebaseAuth.instance.signInWithCredential(faceCredential).then((value) {
        userCreate(
          name: value.user!.displayName!,
          email: value.user!.email!,
          phone: '+01255487746465',
          usId: value.user!.uid,
          isEmailVerified: false,
        );
      });
    }
  }

 //create user (doc) in firebase firestore and save his data, this function called after register.
  void userCreate(
      {
        required String name,
        required String email,
        required String phone,
        required String usId,
        required bool isEmailVerified,
      }){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: usId,
      isEmailVerified: isEmailVerified,
      image: 'https://cdn.landesa.org/wp-content/uploads/default-user-image.png',
      coverImage: 'https://img.freepik.com/free-photo/full-shot-woman-running-outdoors_23-2149622958.jpg?t=st=1693073648~exp=1693074248~hmac=c0db97a92eb3f7fbf1f39ed5e020ba5a3ecba60d9f00d8eee5386f173c13080a',
      bio: 'write your bio..',
      noOfPosts: 0,
      noOfFollowers: 0,
      noOfFollowing: 0,
      noOfFriends: 0,
      //userPosts: null,
    );
     FirebaseFirestore.instance
         .collection('users')
         .doc(usId)
         .set(model.toMap())
         .then((value) {
          emit(SocialCreateUserSuccessState(usId));
     }).catchError((error){
        emit(SocialCreateUserErrorState(error.toString()));
     });

  }

  //change password visibility
  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegChangePasswordVisibilityState());
  }
  //change confirm password visibility
  void changeConfirmPasswordVisibility() {
    isCheckPassword = !isCheckPassword;
    confirmIcon =
    isCheckPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegChangePasswordVisibilityState());
  }
}
