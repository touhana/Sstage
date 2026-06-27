import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import 'disponibilites_screen.dart';
import 'rdv_recus_screen.dart';
import 'consultations_screen.dart';
import 'etablissements_screen.dart';
import 'login_screen.dart';

class HomeMedecinScreen extends StatelessWidget {
  const HomeMedecinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Espace Médecin"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bonjour Docteur 👨‍⚕️",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Que voulez-vous faire ?",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildCard(
                    context,
                    "Mes disponibilités",
                    Icons.calendar_today,
                    AppColors.primary,
                    const DisponibilitesScreen(),
                  ),
                  _buildCard(
                    context,
                    "Rendez-vous reçus",
                    Icons.event_note,
                    Colors.orange,
                    const RdvRecusScreen(),
                  ),
                  _buildCard(
                    context,
                    "Consultations",
                    Icons.medical_services,
                    AppColors.success,
                    const ConsultationsScreen(),
                  ),
                  _buildCard(
                    context,
                    "Établissements",
                    Icons.local_hospital,
                    Colors.blue,
                    const EtablissementsScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String titre,
    IconData icone,
    Color couleur,
    Widget page,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: couleur.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: couleur.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: couleur, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              titre,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
