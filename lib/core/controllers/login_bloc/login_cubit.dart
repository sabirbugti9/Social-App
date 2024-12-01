import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData icon = Icons.visibility_outlined;

  //method to login user by firebase Auth
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  // sign in with google method
  signInWithGoogle() async{
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
    return FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    });
  }



  // sign in with facebook method
  signInWithFacebook() async{
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
        emit(SocialLoginSuccessState(value.user!.uid));
      });
    }
  }

  // change password visibility method
  void changePasswordVisibility() {
    isPassword = !isPassword;
    icon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialpChangePasswordVisibilityState());
  }
}
