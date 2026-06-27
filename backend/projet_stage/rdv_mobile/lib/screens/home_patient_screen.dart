import 'package:flutter/material.dart';
import 'rendezvous_screen.dart';
import 'medecins_screen.dart';
import 'specialites_screen.dart';
import 'mes_rendezvous_screen.dart';
import 'notifications_screen.dart';
class HomePatientScreen extends StatelessWidget {


  const HomePatientScreen({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "Accueil Patient"
        ),

      ),



      body: Padding(


        padding:
        const EdgeInsets.all(20),



        child: Column(


          children: [


            const Text(

              "Bienvenue dans votre espace patient",

              style: TextStyle(

                fontSize: 20,

                fontWeight: FontWeight.bold,

              ),

            ),



            const SizedBox(height:30),



            ElevatedButton(

            onPressed: () {

  Navigator.push(

    context,

    MaterialPageRoute(

      builder: (context) =>
          const MedecinsScreen(),

    ),

  );

},

              child:
              const Text(
                "Liste des médecins"
              ),

            ),



          ElevatedButton(

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context) =>
            const SpecialitesScreen(),

      ),

    );

  },

  child:
  const Text(
    "Spécialités"
  ),

),


           ElevatedButton(

  onPressed: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context) =>
            const RendezVousScreen(),

      ),

    );

  },


  child:
  const Text(
    "Prendre un rendez-vous"
  ),

),

          ElevatedButton(

  onPressed: () {


    Navigator.push(

      context,

      MaterialPageRoute(
builder: (context) =>
     const MesRendezVousScreen(),
      ),

    );


  },


  child:
  const Text(
    "Mes rendez-vous"
  ),

),


           ElevatedButton(

  onPressed: () {


    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context)=>
            const NotificationsScreen(),

      ),

    );


  },


  child:
  const Text(
    "Notifications"
  ),

),

          ],


        ),


      ),


    );

  }


}