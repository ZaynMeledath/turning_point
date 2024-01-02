// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SignedOutState()) {
    on<SignInButtonPressedEvent>(
      (event, emit) async {
        try {
          // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          // // Obtain the auth details from the request
          // final GoogleSignInAuthentication? googleAuth =
          //     await googleUser?.authentication;

          // // Create a new credential
          // final credential = GoogleAuthProvider.credential(
          //   accessToken: googleAuth?.accessToken,
          //   idToken: googleAuth?.idToken,
          // );

          // // Once signed in, return the UserCredential

          // await FirebaseAuth.instance.signInWithCredential(credential);

          return emit(GoogleSignInSucess());
        } catch (e) {
          print(e);
        }
      },
    );
  }
}
