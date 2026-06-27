import 'package:flutter/material.dart';

import '../services/auth_service.dart';



class RegisterPatientScreen extends StatefulWidget {

  const RegisterPatientScreen({super.key});


  @override
  State<RegisterPatientScreen> createState() =>
      _RegisterPatientScreenState();

}




class _RegisterPatientScreenState
    extends State<RegisterPatientScreen> {



  final nomController =
      TextEditingController();


  final prenomController =
      TextEditingController();


  final emailController =
      TextEditingController();


  final telephoneController =
      TextEditingController();


  final passwordController =
      TextEditingController();


final dateNaissanceController =
    TextEditingController();
  bool loading = false;

// final usernameController = TextEditingController();


  Future<void> inscrire() async {


    setState(() {

      loading = true;

    });



    try {


      final response =
     await AuthService.registerPatient({

  // "username": usernameController.text,

  "email": emailController.text,

  "password": passwordController.text,

  "nom": nomController.text,

  "prenom": prenomController.text,

  "date_naissance": dateNaissanceController.text,

  "telephone": telephoneController.text,

});



      print(response);



      setState(() {

        loading = false;

      });



      ScaffoldMessenger.of(context)
          .showSnackBar(


        const SnackBar(

          content:
          Text(
              "Compte créé avec succès"
          ),

        ),


      );



      Navigator.pop(context);



    }

    catch(e){


      print(e);



      setState(() {

        loading = false;

      });



      ScaffoldMessenger.of(context)
          .showSnackBar(


        SnackBar(

          content:
          Text(
              "Erreur : $e"
          ),

        ),


      );


    }


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
            "Inscription Patient"
        ),

      ),



      body: Padding(


        padding:
        const EdgeInsets.all(20),



        child: SingleChildScrollView(


          child: Column(


            children: [



              TextField(

                controller:
                nomController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Nom",

                  border:
                  OutlineInputBorder(),

                ),

              ),



              const SizedBox(height:15),



              TextField(

                controller:
                prenomController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Prénom",

                  border:
                  OutlineInputBorder(),

                ),

              ),



              const SizedBox(height:15),




              TextField(

                controller:
                emailController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Email",

                  border:
                  OutlineInputBorder(),

                ),

              ),



              const SizedBox(height:15),



              TextField(

                controller:
                telephoneController,

                decoration:
                const InputDecoration(

                  labelText:
                  "Téléphone",

                  border:
                  OutlineInputBorder(),

                ),

              ),



              const SizedBox(height:15),



              TextField(

                controller:
                passwordController,

                obscureText:true,

                decoration:
                const InputDecoration(

                  labelText:
                  "Mot de passe",

                  border:
                  OutlineInputBorder(),

                ),

              ),



              const SizedBox(height:30),



TextField(

  controller: dateNaissanceController,

  decoration: const InputDecoration(

    labelText: "Date de naissance",

    hintText: "2000-01-01",

    border: OutlineInputBorder(),

  ),

),

const SizedBox(height: 20),
              ElevatedButton(


                onPressed:
                loading
                    ?
                null
                    :
                inscrire,



                child:


                loading


                    ?


                const CircularProgressIndicator()



                    :


                const Text(

                    "Créer un compte"

                ),



              ),



            ],


          ),


        ),


      ),


    );

  }


}