part of 'barrel.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthenticationService>(
      create: (_) => AuthenticationService(FirebaseAuth.instance),
      child: SignUpPage());
  }

  void _back(BuildContext context) {
    Navigator.pop(context);
  }


  //registrasi
  void _signUp(BuildContext context, String username, String email, String password) async {
    var accountdata = VerificationArgs(username: username, email: email, password: password);

    EasyLoading.show(
      status: 'Loading',
      maskType: EasyLoadingMaskType.black,
    );

    var result = await context.read<AuthenticationService>().signup(accountdata, context);
    
    EasyLoading.dismiss();
    if (result) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      SnackBarComponent.snackbar(context, SnackbarStatus.error, 'Error occured when create new account');
    }
  }
}
