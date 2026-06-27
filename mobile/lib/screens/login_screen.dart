// import 'package:flutter/material.dart';

// import '../services/auth_service.dart';

// import 'home_patient_screen.dart';

// import 'register_patient_screen.dart';



// class LoginScreen extends StatefulWidget {


//   const LoginScreen({super.key});


//   @override
//   State<LoginScreen> createState() =>
//       _LoginScreenState();

// }




// class _LoginScreenState extends State<LoginScreen> {


//   final usernameController =
//       TextEditingController();


//   final passwordController =
//       TextEditingController();



//   bool loading = false;



//   void login() async {


//     setState(() {

//       loading = true;

//     });



//     bool success =
//         await AuthService.login(

//           usernameController.text,

//           passwordController.text,

//         );



//     setState(() {

//       loading = false;

//     });



//     if(success){


//       String? role =
//       await AuthService.getRole();



//       if(role == "patient"){


//         Navigator.pushReplacement(

//           context,

//           MaterialPageRoute(

//             builder: (context)=>
//             const HomePatientScreen(),

//           ),

//         );


//       }


//       else{


//         ScaffoldMessenger.of(context)
//             .showSnackBar(

//           const SnackBar(

//             content:
//             Text(
//                 "Compte médecin"
//             ),

//           ),

//         );

//       }



//     }


//     else{


//       ScaffoldMessenger.of(context)
//           .showSnackBar(

//         const SnackBar(

//           content:
//           Text(
//               "Login incorrect"
//           ),

//         ),

//       );


//     }



//   }





//   @override
//   Widget build(BuildContext context) {


//     return Scaffold(


//       appBar: AppBar(

//         title:
//         const Text(
//             "Connexion"
//         ),

//       ),



//       body: Padding(


//         padding:
//         const EdgeInsets.all(20),



//         child: Column(


//           children: [



//             TextField(

//               controller:
//               usernameController,


//               decoration:
//               const InputDecoration(

//                 labelText:
//                 "Username",

//                 border:
//                 OutlineInputBorder(),

//               ),

//             ),




//             const SizedBox(height:20),




//             TextField(

//               controller:
//               passwordController,


//               obscureText:true,


//               decoration:
//               const InputDecoration(

//                 labelText:
//                 "Password",

//                 border:
//                 OutlineInputBorder(),

//               ),

//             ),




//             const SizedBox(height:30),





//             ElevatedButton(


//               onPressed:
//               loading ? null : login,



//               child:


//               loading


//               ?


//               const CircularProgressIndicator()


//               :


//               const Text(

//                 "Se connecter"

//               ),


//             ),





//             const SizedBox(height:20),





//             TextButton(


//               onPressed: () {



//                 Navigator.push(


//                   context,


//                   MaterialPageRoute(


//                     builder: (context) =>

//                     const RegisterPatientScreen(),


//                   ),


//                 );


//               },



//               child:


//               const Text(

//                 "Créer un compte patient"

//               ),



//             ),




//           ],


//         ),


//       ),


//     );

//   }


// }

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import 'home_patient_screen.dart';
import 'home_medecin_screen.dart';
import 'register_patient_screen.dart';
import 'register_medecin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  void login() async {
    setState(() => loading = true);

    bool success = await AuthService.login(
      usernameController.text,
      passwordController.text,
    );

    setState(() => loading = false);

    if (!mounted) return;

    if (success) {
      String? role = await AuthService.getRole();

      if (role == "patient") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePatientScreen()),
        );
      } else if (role == "medecin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeMedecinScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email ou mot de passe incorrect"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Connexion"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_hospital, size: 64, color: AppColors.primary),
            const SizedBox(height: 24),
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Mot de passe",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Se connecter",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterPatientScreen()),
              ),
              child: const Text("Créer un compte patient"),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RegisterMedecinScreen()),
              ),
              child: const Text(
                "Créer un compte médecin",
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}