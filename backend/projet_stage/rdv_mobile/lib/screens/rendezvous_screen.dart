import 'package:flutter/material.dart';

import '../models/medecin_model.dart';
import '../services/medecin_service.dart';
import '../services/rendezvous_service.dart';


class RendezVousScreen extends StatefulWidget {

  const RendezVousScreen({super.key});


  @override
  State<RendezVousScreen> createState() =>
      _RendezVousScreenState();

}



class _RendezVousScreenState
    extends State<RendezVousScreen> {


  List<Medecin> medecins = [];

  Medecin? medecinChoisi;


  final dateController =
      TextEditingController();


  final heureController =
      TextEditingController();


  bool loading = true;



  @override
  void initState() {

    super.initState();

    chargerMedecins();

  }



  Future<void> chargerMedecins() async {


    final data =
        await MedecinService.getMedecins();


    setState(() {

      medecins = data;

      loading = false;

    });

  }



  Future<void> envoyerRendezVous() async {


    if (medecinChoisi == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
          Text(
            "Choisir un médecin"
          ),
        ),

      );

      return;

    }



    final response =
        await RendezVousService.creerRendezVous({

      "date_rdv":
          dateController.text,


      "heure_rdv":
          heureController.text,


      "medecin":
          medecinChoisi!.id,


    });



    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content:
        Text(
          "Rendez-vous envoyé"
        ),

      ),

    );

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
          "Prendre un rendez-vous"
        ),

      ),



      body: loading

          ? const Center(

              child:
              CircularProgressIndicator(),

            )


          : Padding(

              padding:
              const EdgeInsets.all(20),


              child: Column(

                children: [


                  DropdownButton<Medecin>(


                    isExpanded: true,


                    hint:
                    const Text(
                      "Choisir un médecin"
                    ),


                    value:
                    medecinChoisi,


                    items:
                    medecins.map((medecin){


                      return DropdownMenuItem(

                        value: medecin,


                        child:
                        Text(
                          "${medecin.prenom} ${medecin.nom}"
                        ),

                      );


                    }).toList(),



                    onChanged:(value){


                      setState(() {

                        medecinChoisi =
                            value;

                      });


                    },


                  ),



                  TextField(

                    controller:
                    dateController,


                    decoration:
                    const InputDecoration(

                      labelText:
                      "Date (YYYY-MM-DD)"

                    ),

                  ),



                  TextField(

                    controller:
                    heureController,


                    decoration:
                    const InputDecoration(

                      labelText:
                      "Heure (HH:MM:SS)"

                    ),

                  ),



                  const SizedBox(
                    height:30
                  ),



                  ElevatedButton(

                    onPressed:
                    envoyerRendezVous,


                    child:
                    const Text(
                      "Confirmer rendez-vous"
                    ),

                  )


                ],

              ),

            ),


    );


  }


}