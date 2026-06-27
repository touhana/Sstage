// import 'package:shared_preferences/shared_preferences.dart';

// import 'api_service.dart';

// import '../models/rendezvous_model.dart';
// class RendezVousService {


//   static Future<dynamic> creerRendezVous(

//       Map<String, dynamic> data

//       ) async {


//     final prefs =
//         await SharedPreferences.getInstance();


//     String? token =
//         prefs.getString("access");


//     if (token == null) {

//       return null;

//     }


//     final response =
//         await ApiService.post(
//           "rendezvous/",
//           data,
//         );
// print(response);

//     return response;


//   }

// static Future<List<RendezVous>> getMesRendezVous() async {


//   final prefs =
//       await SharedPreferences.getInstance();


//   String? token =
//       prefs.getString("access");


//   if(token == null){

//     return [];

//   }



//   final response =
//       await ApiService.get(
//         "rendezvous/",
//         token,
//       );



//   return (response as List)
//       .map(
//         (json) =>
//             RendezVous.fromJson(json),
//       )
//       .toList();


// }
// }

import 'api_service.dart';
import '../models/rendezvous_model.dart';


class RendezVousService {


  static Future<dynamic> creerRendezVous(
      Map<String, dynamic> data
      ) async {


    final response =
        await ApiService.post("rendezvous/", data);

    print(response);

    return response;

  }


  static Future<List<RendezVous>> getMesRendezVous() async {


    final response =
        await ApiService.get("rendezvous/");


    return (response as List)
        .map((json) => RendezVous.fromJson(json))
        .toList();

  }

}
