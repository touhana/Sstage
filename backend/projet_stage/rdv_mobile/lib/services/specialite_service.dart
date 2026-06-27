import 'package:shared_preferences/shared_preferences.dart';

import '../models/specialite_model.dart';
import 'api_service.dart';


class SpecialiteService {


  static Future<List<Specialite>> getSpecialites() async {


    final prefs =
        await SharedPreferences.getInstance();


    String? token =
        prefs.getString("access");


    if (token == null) {

      return [];

    }


    final response =
        await ApiService.get(
      "specialites/",
      token,
    );


    if (response is List) {


      return response
          .map(
            (json) =>
                Specialite.fromJson(json),
          )
          .toList();

    }


    return [];

  }

}