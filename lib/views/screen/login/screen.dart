part of 'barrel.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }

  //FUNCTION in login page
  void _createAccount(BuildContext context) {
    Navigator.pushNamed(context, '/signup');
  }

  Future _login(String email, String password, BuildContext context) async {
    FocusScope.of(context).unfocus();
    EasyLoading.show(
      status: 'Loading',
      maskType: EasyLoadingMaskType.black,
    );
    var result = await context.read<AuthenticationService>().signin(email, password);
    EasyLoading.dismiss();
    if (!result){
      SnackBarComponent.snackbar(context, SnackbarStatus.error, 'Wrong username or password');
    }
  }
}