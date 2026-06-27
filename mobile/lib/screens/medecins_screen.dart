import 'package:flutter/material.dart';

import '../models/medecin_model.dart';
import '../services/medecin_service.dart';

class MedecinsScreen extends StatefulWidget {

  const MedecinsScreen({super.key});

  @override
  State<MedecinsScreen> createState() =>
      _MedecinsScreenState();
}

class _MedecinsScreenState
    extends State<MedecinsScreen> {

  List<Medecin> medecins = [];

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Liste des médecins",
        ),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(

              itemCount:
                  medecins.length,

              itemBuilder:
                  (context, index) {

                final medecin =
                    medecins[index];

                return Card(

                  margin:
                      const EdgeInsets.all(10),

                  child: ListTile(

                    title: Text(
                      "${medecin.prenom} ${medecin.nom}",
                    ),

                    subtitle: Text(
                      "Téléphone : ${medecin.telephone}",
                    ),

                  ),

                );
              },
            ),
    );
  }
}