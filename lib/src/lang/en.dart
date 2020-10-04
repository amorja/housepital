// this file contains language for specific string


class CommonLang {

  static const OK = 'Ok';
  static const Technifybiz = 'Technifybiz';
  static const CANCEL = 'Cancel';
  static const Save = 'SAVE';
  static const Talk_to_us = 'TALK TO US';
  static const Upload = 'Uploads';
  static const Update = 'Update';
  static const Next = 'Next';
  static const Verify = 'Verify';
  static const Done = 'Done';
  static const HOME = 'Home';
  static const BID = 'Bids';
  static const News = 'News';
  static const MYORDERS = 'My Orders';
  static const SETTINGS = 'Settings';
  static const COMMODITY = 'Commodity';
  static const PRICE_Symbol = '\u20B9';
  static const Join_Now = 'JOIN NOW';
  static const Subline = 'Smartly trade your commodities for best prices';

}
class LoginLang {
  // this only contains string for login screen;
  static const LOGIN = 'Login';
  static const WELCOME_TO_Technify = 'Welcome Onboard';
  static const MOBILE_NUMBER = 'Mobile Number';
}
class IntroScreenLang{
  // this only contains string for login screen;
  static const Quantity_Placeholder = 'Enter Quantity';
  static const Company_Details = 'Company Details';
  static const Company_name_Placeholder = 'Company’s Trading Name';
  static const Company_name_Message = 'Ensure this name is same as in subsequent documents.';
  static const Primary_Contact = 'Primary Contact';
  static const Contact_person_Placeholder = 'Contact Person’s Name';
  static const Email_Placeholder = 'Email';
  static const Mobile_Placeholder = 'Mobile';
  static const Next_Upload = 'Next Step: Upload Documents';
  static const Add_Address = 'Add New Address';
  static const Address_name_Placeholder = 'Name of building, unit, warehouse*';
  static const Shop_no_Placeholder = 'Shop No./Line 1';
  static const Street_name_Placeholder = 'Street Name/Line 2';
  static const Locality_Placeholder = 'Locality';
  static const Landmark_Placeholder = 'Landmark';
  static const Nickname_Placeholder = 'Nickname';
  static const Tags_Placeholder = 'Tags';
  static const Pincode_Placeholder = 'Pincode';
  static const City_Placeholder = 'City';
  static const State_Placeholder = 'State';
  static const Skip_Details = 'Skip Details';
  static const Next_Address = 'Next Step: Add Addresses';
  static const Document_Upload = 'Document Upload';
  static const PAN_Card = 'PAN Card';
  static const Aadhaar_Card = 'Aadhaar Card';
  static const MSME_Number = 'MSME Number';
  static const Cancelled_Cheque = 'Cancelled Cheque';
  static const Document_Upload_Message = 'To activate your account for trading, we require following documents';
  static const Type_of_Organisation = 'Type of Organisation';
  static const Document_Required = 'Documents Required';
  static const Private_firm = 'Private Firm';
  static const Proprietorship_firm = 'Proprietorship Firm';
  static const Company_GST = 'Company\'s GST';
  static const Company_PAN = 'Company\'s PAN';
  static const Director_Aadhar = 'Director/Proprietor\'s Aadhar';
  static const Director_PAN = 'Director/Proprietor\'s PAN';
  
}

class HErrorText {
  static const RETRY = 'Retry';
  static const ERROR = {
    '500': {
      'title': 'Please Try again!',
      'icon': 'warning' /// icon will be provided as disscussed with PM
    },
    '501': {
      'title': 'Server does not support the functionality required to fulfill the request!',
      'icon': 'warning' /// icon will be provided as disscussed with PM
    },
    '502': {
      'title': 'Got Invalid Response from server!',
      'icon': 'warning' /// icon will be provided as disscussed with PM
    },
    '503': {
      'title': 'The server is not ready to handle the request!',
      'icon': 'warning' /// icon will be provided as disscussed with PM
    },
    '504': {
      'title': 'Gateway Timeout!',
      'icon': 'warning' /// icon will be provided as disscussed with PM
    }
  };
}

class VersionUpdateText {
  static String title = "New Update Available";
  static String message = "There is a newer version of app available please update it now.";
  static String btnLabel = "Update Now";
  static String btnLabelCancel = "Later";
}

class SearchLang {
  static String enterText = 'Search products and qualities';
}

