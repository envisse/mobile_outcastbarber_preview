part of '../barrel.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(
              Dimens.horizontalMargin,
              MediaQuery.of(context).size.height * 0.2,
              Dimens.horizontalMargin,
              0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(text: 'Login', textStyling: TextStyling.heading2),
                SizedBox(height: 10),
                TextFieldComponent(
                    textEditingController: _emailcontroller,
                    labelText: 'email',
                    validator: RequiredValidator(errorText: 'Required')),
                SizedBox(height: 10),
                TextFieldComponent(
                    textEditingController: _passwordcontroller,
                    labelText: 'password',
                    obsecuretext: true,
                    validator: RequiredValidator(errorText: 'Required')),
                SizedBox(height: 10),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ButtonContainedComponent(
                        onPressed: () {
                          if (!_key.currentState!.validate()) {
                            SnackBarComponent.snackbar(
                                context, SnackbarStatus.error, 'Invalid Input');
                            return null;
                          }
                          LoginScreen()
                            .._login(_emailcontroller.text,
                                _passwordcontroller.text, context);
                        },
                        text: 'LOGIN',
                        isIcon: false)),
                SizedBox(height: 5),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextComponent(
                      text: 'Not a member yet ?',
                      textStyling: TextStyling.heading5),
                  TextButton(
                      onPressed: () => LoginScreen().._createAccount(context),
                      child: TextComponent(
                        text: 'Create Account',
                        textStyling: TextStyling.heading5,
                        textcolor: ColorsPicker.SecondaryColor,
                      ))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
