import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userIdkey ="USERKEY";
  static String userNamekey ="USERNAMEKEY";
  static String userEmailkey ="USEREMAILKEY";
  static String userWalletkey ="USERWALLETKEY";
  static String userProfilekey ="USERPROFILEKEY";

  Future<bool> saveUserId(String getUserId)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userIdkey, getUserId);
  }
  Future<bool> saveUserName(String getUserName)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userNamekey, getUserName);
  }
  Future<bool> saveUserIdEmail(String getUserEmail)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userEmailkey, getUserEmail);
  }
  Future<bool> saveUserWallet(String getUserWallet)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userWalletkey, getUserWallet);
  }
  Future<bool> saveUserProfile(String getUserProfile)async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    return pref.setString(userProfilekey, getUserProfile);
  }

  Future<String?> getUserId() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userIdkey);
  }
  Future<String?> getUserName() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userNamekey);
  }
  Future<String?> getUserEmail() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userEmailkey);
  }
  Future<String?> getUserWallet() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userWalletkey);
  }
  Future<String?> getUserProfile() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    return pref.getString(userProfilekey);
  }
}