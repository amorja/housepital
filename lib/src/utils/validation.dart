    bool validateName(String value) {
     final RegExp regex = new RegExp(r'([a-zA-Z]{2,})');
      return regex.hasMatch(value);
    } 

    bool isValidMobile(String input) {
      final RegExp regex = new RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
      return regex.hasMatch(input);
    }
    bool isValidNum(String input) {
      final RegExp regex = new RegExp(r'([0-9]{2,})');
      return regex.hasMatch(input);
    }
    bool isValidEmail(String input) {
      final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
      return regex.hasMatch(input);
    }
    bool isValidPAN(String input) {
      final RegExp regex = new RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}");
      return regex.hasMatch(input);
    }
    bool isValidAadhaar(String input) {
      final RegExp regex = new RegExp(r"^\d{4}\d{4}\d{4}$");
      return regex.hasMatch(input);
    }
    bool isValidMSME(String input) {
      final RegExp regex = new RegExp(r"([a-zA-Z0-9]{12})");
      return regex.hasMatch(input);
    }
    bool validateDispatch(String input,double quantity){
      if(int.parse(input) < quantity){
        return true;
      }else{
        return false;
      }

    }
