// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyController extends GetxController {
  final googleSignIn = GoogleSignIn();
  final fb = FacebookLogin();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  String? _email;

  String get email => _email!;

  bool? _isFbLogin;

  bool get isFbLogin => _isFbLogin!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    update();
  }

  Future googleLogout() async {
    final isGoogle = googleSignIn.isSignedIn();

    if (await isGoogle) {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    }

    await fb.logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future facebookLogin() async {
    // final facebookLoginResult = await FacebookAuth.instance.login();

    // final facebookCredential =
    //     FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);

    // await FirebaseAuth.instance.signInWithCredential(facebookCredential);

   

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        _isFbLogin = true;
        // final result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        if (email == null) return;
        _email = email;

        update();

        // But user can decline permission
 print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }

    update();

  }
}
