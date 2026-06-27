import 'package:flutter/material.dart';

import '../models/rendezvous_model.dart';
import '../services/rendezvous_service.dart';



class MesRendezVousScreen extends StatefulWidget {

  const MesRendezVousScreen({super.key});


  @override
  State<MesRendezVousScreen> createState() =>
      _MesRendezVousScreenState();

}




class _MesRendezVousScreenState
    extends State<MesRendezVousScreen> {


  List<RendezVous> rendezvous = [];

  bool loading = true;



  @override
  void initState() {

    super.initState();

    chargerRendezVous();

  }



  Future<void> chargerRendezVous() async {


    final data =
        await RendezVousService.getMesRendezVous();



    setState(() {

      rendezvous = data;

      loading = false;

    });


  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
          "Mes rendez-vous"
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

      rendezvous.isEmpty


      ?

      const Center(

        child:
        Text(
          "Aucun rendez-vous"
        ),

      )


      :

      ListView.builder(


        itemCount:
        rendezvous.length,


        itemBuilder:
        (context,index){


          final rdv =
              rendezvous[index];



          return Card(


            margin:
            const EdgeInsets.all(10),


            child:
            ListTile(


              title:
              Text(
                "Date : ${rdv.dateRdv}"
              ),



              subtitle:
              Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,


                children: [


                  Text(
                    "Heure : ${rdv.heureRdv}"
                  ),


                  Text(
                    "Médecin ID : ${rdv.medecin}"
                  ),


                  Text(
                    "Statut : ${rdv.statut}"
                  ),


                ],

              ),


            ),


          );


        },


      ),


    );


  }


}