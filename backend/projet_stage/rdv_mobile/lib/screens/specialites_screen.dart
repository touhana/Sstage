import 'package:flutter/material.dart';

import '../models/specialite_model.dart';
import '../services/specialite_service.dart';


class SpecialitesScreen extends StatefulWidget {

  const SpecialitesScreen({super.key});


  @override
  State<SpecialitesScreen> createState() =>
      _SpecialitesScreenState();

}



class _SpecialitesScreenState
    extends State<SpecialitesScreen> {


  List<Specialite> specialites = [];


  bool loading = true;



  @override
  void initState() {

    super.initState();

    chargerSpecialites();

  }



  Future<void> chargerSpecialites() async {


    final data =
        await SpecialiteService.getSpecialites();



    setState(() {

      specialites = data;

      loading = false;

    });


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "Spécialités médicales"
            ),

      ),



      body: loading


          ? const Center(

              child:
                  CircularProgressIndicator(),

            )



          : ListView.builder(


              itemCount:
                  specialites.length,



              itemBuilder:
                  (context,index){


                final specialite =
                    specialites[index];



                return Card(


                  margin:
                      const EdgeInsets.all(10),



                  child: ListTile(


                    title:
                        Text(
                          specialite.libelle,
                        ),


                  ),


                );


              },

            ),


    );


  }


}