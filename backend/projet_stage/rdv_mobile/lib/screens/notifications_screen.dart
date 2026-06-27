import 'package:flutter/material.dart';

import '../models/notification_model.dart';
import '../services/notification_service.dart';



class NotificationsScreen extends StatefulWidget {


  const NotificationsScreen({super.key});


  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();

}



class _NotificationsScreenState
    extends State<NotificationsScreen> {



  List<NotificationModel> notifications = [];


  bool loading = true;



  @override
  void initState(){

    super.initState();

    chargerNotifications();

  }



  Future<void> chargerNotifications() async {


    final data =
        await NotificationService.getNotifications();



    setState(() {

      notifications = data;

      loading = false;

    });


  }



  @override
  Widget build(BuildContext context){


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "Notifications"
        ),

      ),



      body:

      loading

      ?

      const Center(

        child:
        CircularProgressIndicator(),

      )


      :

      notifications.isEmpty


      ?

      const Center(

        child:
        Text(
          "Aucune notification"
        ),

      )


      :


      ListView.builder(


        itemCount:
        notifications.length,


        itemBuilder:
        (context,index){


          final notification =
              notifications[index];



          return Card(


            margin:
            const EdgeInsets.all(10),


            child:
            ListTile(


              title:
              Text(
                notification.message
              ),



              subtitle:
Text(
 notification.dateEnvoi
)

            ),


          );


        },


      ),


    );


  }


}