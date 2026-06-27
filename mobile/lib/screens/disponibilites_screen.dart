import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class DisponibilitesScreen extends StatefulWidget {
  const DisponibilitesScreen({super.key});

  @override
  State<DisponibilitesScreen> createState() =>
      _DisponibilitesScreenState();
}

class _DisponibilitesScreenState
    extends State<DisponibilitesScreen> {
  List<dynamic> _disponibilites = [];
  bool _loading = true;

  DateTime? _dateChoisie;
  TimeOfDay? _heureChoisie;

  @override
  void initState() {
    super.initState();
    _chargerDisponibilites();
  }

  Future<void> _chargerDisponibilites() async {
    setState(() => _loading = true);
    try {
      final data =
          await ApiService.get("medecin/disponibilites/");
      setState(() {
        _disponibilites = data is List ? data : [];
      });
    } catch (e) {
      setState(() => _disponibilites = []);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _ajouterDisponibilite() async {
    if (_dateChoisie == null || _heureChoisie == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Choisissez une date et une heure"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final dateStr =
          "${_dateChoisie!.year.toString().padLeft(4, '0')}-"
          "${_dateChoisie!.month.toString().padLeft(2, '0')}-"
          "${_dateChoisie!.day.toString().padLeft(2, '0')}";
      final heureStr =
          "${_heureChoisie!.hour.toString().padLeft(2, '0')}:"
          "${_heureChoisie!.minute.toString().padLeft(2, '0')}";

      await ApiService.post("medecin/disponibilites/", {
        "date": dateStr,
        "heure": heureStr,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Disponibilité ajoutée !"),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          _dateChoisie = null;
          _heureChoisie = null;
        });
        _chargerDisponibilites();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : $e")),
        );
      }
    }
  }

  Future<void> _supprimerDisponibilite(int id) async {
    try {
      await ApiService.delete(
          "medecin/disponibilites/$id/");
      _chargerDisponibilites();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Mes Disponibilités"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Formulaire ajout
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ajouter un créneau",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final date =
                                await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              setState(
                                () => _dateChoisie = date,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.calendar_today,
                            size: 18,
                          ),
                          label: Text(
                            _dateChoisie == null
                                ? "Date"
                                : "${_dateChoisie!.day}/${_dateChoisie!.month}/${_dateChoisie!.year}",
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final heure =
                                await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (heure != null) {
                              setState(
                                () =>
                                    _heureChoisie = heure,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.access_time,
                            size: 18,
                          ),
                          label: Text(
                            _heureChoisie == null
                                ? "Heure"
                                : _heureChoisie!
                                    .format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _ajouterDisponibilite,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Ajouter",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Liste disponibilités
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _disponibilites.isEmpty
                      ? const Center(
                          child: Text(
                            "Aucune disponibilité ajoutée",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount:
                              _disponibilites.length,
                          itemBuilder: (context, index) {
                            final d =
                                _disponibilites[index];
                            return Card(
                              margin: const EdgeInsets
                                  .only(bottom: 8),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.access_time,
                                  color: AppColors.primary,
                                ),
                                title: Text(
                                  d["date"] ?? "",
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  d["heure"] ?? "",
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      _supprimerDisponibilite(
                                    d["id"],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
