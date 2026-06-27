// import 'package:shared_preferences/shared_preferences.dart';

// import 'api_service.dart';


// class AuthService {


//   // ==========================
//   // LOGIN
//   // ==========================

//  static Future<bool> login(
//     String email,
//     String password
//     ) async {


//     final response = await ApiService.post(

//       "login/",

//       {
//         "email": email,

//         "password": password,

//       },

//     );

//     // Si Django retourne un token

//     if(response["access"] != null){


//       final prefs =
//       await SharedPreferences.getInstance();



//       await prefs.setString(
//         "access",
//         response["access"],
//       );



//       await prefs.setString(
//         "refresh",
//         response["refresh"],
//       );



//      await prefs.setString(
//   "email",
//   response["email"],
// );



//       await prefs.setString(
//         "role",
//         response["role"],
//       );



//       return true;

//     }


//     return false;


//   }




//   // ==========================
//   // RECUPERER ROLE
//   // ==========================

//   static Future<String?> getRole() async {


//     final prefs =
//     await SharedPreferences.getInstance();


//     return prefs.getString(
//       "role"
//     );


//   }





//   // ==========================
//   // LOGOUT
//   // ==========================

//   static Future<void> logout() async {


//     final prefs =
//     await SharedPreferences.getInstance();


//     await prefs.clear();


//   }
// static Future<dynamic> registerPatient(
//     Map<String, dynamic> data
//     ) async {


//   final response =
//       await ApiService.post(

//         "register/patient/",

//         data,

//       );


//   return response;

// }

// }

import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {

  // LOGIN
  static Future<bool> login(
    String email,
    String password,
  ) async {
    final response = await ApiService.post(
      "login/",
      {"email": email, "password": password},
    );
    if (response["access"] != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("access", response["access"]);
      await prefs.setString("refresh", response["refresh"]);
      await prefs.setString("email", response["email"]);
      await prefs.setString("role", response["role"]);
      return true;
    }
    return false;
  }

  // RECUPERER ROLE
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  // LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // INSCRIPTION PATIENT
  static Future<dynamic> registerPatient(
    Map<String, dynamic> data,
  ) async {
    return await ApiService.post("register/patient/", data);
  }

  // INSCRIPTION MEDECIN
  static Future<dynamic> registerMedecin(
    Map<String, dynamic> data,
  ) async {
    return await ApiService.post("register/medecin/", data);
  }
}