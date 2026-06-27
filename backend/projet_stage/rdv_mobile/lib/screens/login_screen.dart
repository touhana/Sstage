import 'package:flutter/material.dart';

import '../services/auth_service.dart';

import 'home_patient_screen.dart';

import 'register_patient_screen.dart';



class LoginScreen extends StatefulWidget {


  const LoginScreen({super.key});


  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();

}




class _LoginScreenState extends State<LoginScreen> {


  final usernameController =
      TextEditingController();


  final passwordController =
      TextEditingController();



  bool loading = false;



  void login() async {


    setState(() {

      loading = true;

    });



    bool success =
        await AuthService.login(

          usernameController.text,

          passwordController.text,

        );



    setState(() {

      loading = false;

    });



    if(success){


      String? role =
      await AuthService.getRole();



      if(role == "patient"){


        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context)=>
            const HomePatientScreen(),

          ),

        );


      }


      else{


        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(

            content:
            Text(
                "Compte médecin"
            ),

          ),

        );

      }



    }


    else{


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:
          Text(
              "Login incorrect"
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
            "Connexion"
        ),

      ),



      body: Padding(


        padding:
        const EdgeInsets.all(20),



        child: Column(


          children: [



            TextField(

              controller:
              usernameController,


              decoration:
              const InputDecoration(

                labelText:
                "Username",

                border:
                OutlineInputBorder(),

              ),

            ),




            const SizedBox(height:20),




            TextField(

              controller:
              passwordController,


              obscureText:true,


              decoration:
              const InputDecoration(

                labelText:
                "Password",

                border:
                OutlineInputBorder(),

              ),

            ),




            const SizedBox(height:30),





            ElevatedButton(


              onPressed:
              loading ? null : login,



              child:


              loading


              ?


              const CircularProgressIndicator()


              :


              const Text(

                "Se connecter"

              ),


            ),





            const SizedBox(height:20),





            TextButton(


              onPressed: () {



                Navigator.push(


                  context,


                  MaterialPageRoute(


                    builder: (context) =>

                    const RegisterPatientScreen(),


                  ),


                );


              },



              child:


              const Text(

                "Créer un compte patient"

              ),



            ),




          ],


        ),


      ),


    );

  }


}