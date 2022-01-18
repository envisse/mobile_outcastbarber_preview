part of '../barrel.dart';

class SignUpPage extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SingleChildScrollView(
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
                    TextComponent(
                        text: 'Sign Up', textStyling: TextStyling.heading2),
                    SizedBox(height: 10),
                    TextFieldComponent(
                        textEditingController: _username,
                        labelText: 'Username',
                        validator: RequiredValidator(errorText: 'Required')),
                    SizedBox(height: 10),
                    TextFieldComponent(
                        textEditingController: _email,
                        labelText: 'Email',
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Required'),
                          EmailValidator(
                              errorText: 'Please eneter a valid email address')
                        ])),
                    SizedBox(height: 10),
                    TextFieldComponent(
                      textEditingController: _password,
                      labelText: 'Password',
                      obsecuretext: true,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Required'),
                        MinLengthValidator(6,
                            errorText: 'At least 6 characters')
                      ]),
                    ),
                    SizedBox(height: 10),
                    TextFieldComponent(
                        textEditingController: _repassword,
                        labelText: 'Confirm password',
                        obsecuretext: true,
                        validator: (val) =>
                            MatchValidator(errorText: "Doesn't match")
                                .validateMatch(val!, _password.text)),
                    SizedBox(height: 10),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ButtonContainedComponent(                          
                            onPressed: () {
                              if (!_key.currentState!.validate()) {
                                SnackBarComponent.snackbar(context,
                                    SnackbarStatus.error, 'Invalid Input');
                                return null;
                              }
                              SignUpScreen()._signUp(context,_username.text,_email.text,_password.text);
                            },
                            text: 'SIGN UP',
                            isIcon: false)),
                  ],
                ),
              )),
        ),
        Positioned(
          top: 1,
          child: Container(
              padding: EdgeInsets.all(8.0),
              child: ButtonIconComponent(
                onPressed: () => SignUpScreen()._back(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                isOutlined: true,
              )),
        ),
      ]),
    ));
  }
}
