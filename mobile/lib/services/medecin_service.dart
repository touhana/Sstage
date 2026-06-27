// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/medecin_model.dart';
// import 'api_service.dart';


// class MedecinService {


//   static Future<List<Medecin>> getMedecins() async {

//     final prefs =
//         await SharedPreferences.getInstance();


//     String? token =
//         prefs.getString("access");


//     if (token == null) {
//       return [];
//     }


//     final response = await ApiService.get(
//       "medecins/",
//       token,
//     );


//     if (response is List) {

//       return response
//           .map(
//             (json) => Medecin.fromJson(json),
//           )
//           .toList();

//     }


//     return [];
//   }


// }


import '../models/medecin_model.dart';
import 'api_service.dart';


class MedecinService {


  static Future<List<Medecin>> getMedecins() async {


    final response =
        await ApiService.get("medecins/");


    if (response is List) {

      return response
          .map((json) => Medecin.fromJson(json))
          .toList();

    }


    return [];

  }


}
