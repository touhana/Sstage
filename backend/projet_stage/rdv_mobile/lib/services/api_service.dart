import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
class ApiService {


  // ============================
  // POST REQUEST
  // ============================

 static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data
    ) async {


  final prefs =
      await SharedPreferences.getInstance();


  String? token =
      prefs.getString("access");



  final url = Uri.parse(
      "${AppConstants.baseUrl}/$endpoint"
  );



  Map<String,String> headers = {

    "Content-Type": "application/json",

  };



  if(token != null){

    headers["Authorization"] =
        "Bearer $token";

  }



  final response = await http.post(

    url,

    headers: headers,

    body: jsonEncode(data),

  );



 try {

  return jsonDecode(response.body);

}

catch(e){

  print("Erreur serveur : ${response.body}");

  return {
    "error": "Erreur serveur"
  };

}

}


  // ============================
  // GET REQUEST
  // ============================

  static Future<dynamic> get(
      String endpoint,
      String token
      ) async {


    final url = Uri.parse(
      "${AppConstants.baseUrl}/$endpoint"
    );


    final response = await http.get(

      url,

      headers: {

        "Content-Type": "application/json",

        "Authorization":
        "Bearer $token",

      },

    );


    return jsonDecode(response.body);

  }


}