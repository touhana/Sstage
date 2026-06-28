import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';
import '../models/specialite_model.dart';
import '../services/specialite_service.dart';
class RegisterMedecinScreen extends StatefulWidget {
  const RegisterMedecinScreen({super.key});

  @override
  State<RegisterMedecinScreen> createState() =>
      _RegisterMedecinScreenState();
}

class _RegisterMedecinScreenState
    extends State<RegisterMedecinScreen> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _specialiteChoisie;
@override
void initState() {

  super.initState();

  chargerSpecialites();

}
List<Specialite> _specialites = [];

bool _loadingSpecialites = true;
  bool _loading = false;
Future<void> chargerSpecialites() async {

  final liste =
      await SpecialiteService.getSpecialites();


  setState(() {

    _specialites = liste;

    _loadingSpecialites = false;

  });

}


  Future<void> _inscrire() async {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _telephoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _specialiteChoisie == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez remplir tous les champs"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text !=
        _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Les mots de passe ne correspondent pas"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await AuthService.registerMedecin({
        "nom": _nomController.text,
        "prenom": _prenomController.text,
        "email": _emailController.text,
        "telephone": _telephoneController.text,
        "password": _passwordController.text,
"specialite": int.parse(_specialiteChoisie!),      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Compte médecin créé avec succès !"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur : $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildChamp(
    String label,
    TextEditingController controller, {
    bool obscure = false,
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Inscription Médecin"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildChamp("Nom", _nomController),
            _buildChamp("Prénom", _prenomController),
            _buildChamp(
              "Email",
              _emailController,
              type: TextInputType.emailAddress,
            ),
            _buildChamp(
              "Téléphone",
              _telephoneController,
              type: TextInputType.phone,
            ),

            // Dropdown spécialité
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: DropdownButtonFormField<String>(
                value: _specialiteChoisie,
                decoration: InputDecoration(
                  labelText: "Spécialité",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              items: _specialites.map((s) {
  return DropdownMenuItem<String>(
    value: s.id.toString(),
    child: Text(s.libelle),
  );
}).toList(),
                onChanged: (val) =>
                    setState(() => _specialiteChoisie = val),
              ),
            ),

            _buildChamp(
              "Mot de passe",
              _passwordController,
              obscure: true,
            ),
            _buildChamp(
              "Confirmer mot de passe",
              _confirmPasswordController,
              obscure: true,
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _loading ? null : _inscrire,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
