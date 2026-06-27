import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';

import 'api_service.dart';



class NotificationService {


static Future<List<NotificationModel>>
getNotifications() async {



final prefs =
await SharedPreferences.getInstance();



String? token =
prefs.getString("access");



if(token == null){

return [];

}



final response =
await ApiService.get(
"notifications/",
token,
);
print(response);


return (response as List)
.map(
(json)=>
NotificationModel.fromJson(json),
)
.toList();


}



}