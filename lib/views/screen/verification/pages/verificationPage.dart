part of '../barrel.dart';

class VerificationPage extends StatelessWidget {
  final TextEditingController _pin = TextEditingController();
  final String setPin;

  VerificationPage({required this.setPin});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(Dimens.horizontalMargin, MediaQuery.of(context).size.height * 0.2, Dimens.horizontalMargin, 0),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              TextComponent(text: 'PIN', textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: PinCodeTextField(
                  obscureText: true,
                  appContext: context,
                  length: 6,
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  controller: _pin,
                  pinTheme: PinTheme(activeColor: ColorsPicker.SecondaryColor, inactiveColor: ColorsPicker.SecondaryColor),
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ButtonContainedComponent(
                    onPressed: () {
                      if (_pin.text.isEmpty || _pin.text.length < 6 || setPin != _pin.text){
                        SnackBarComponent.snackbar(context, SnackbarStatus.error, localization.verificationPage_invalidPin);
                        return;
                      }
                      Navigator.pushReplacementNamed(context, '/',arguments: PinArgs(pinOk: true));
                    },
                    text: localization.verificationPage_submit,
                    isIcon: false),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
