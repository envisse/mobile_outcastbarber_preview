class SettingsData {
  int selectedLanguage;
  bool isPin;
  String? pin;

  SettingsData(this.selectedLanguage,this.isPin,this.pin);
  
  factory SettingsData.fromjson(Map<String,dynamic> json){
    return SettingsData(json['selectedLanguage'], json['isPin'],json['pin']);
  }
  
  Map<String,dynamic> tojson(){
    return {'selectedLanguage': this.selectedLanguage, 'isPin': this.isPin, 'pin': this.pin};
  }
}
