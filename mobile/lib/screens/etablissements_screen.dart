import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class EtablissementsScreen extends StatefulWidget {
  const EtablissementsScreen({super.key});

  @override
  State<EtablissementsScreen> createState() =>
      _EtablissementsScreenState();
}

class _EtablissementsScreenState
    extends State<EtablissementsScreen> {
  List<dynamic> _etablissements = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _charger();
  }

  Future<void> _charger() async {
    setState(() => _loading = true);
    try {
      final data =
          await ApiService.get("etablissements/");
      setState(() {
        _etablissements = data is List ? data : [];
      });
    } catch (e) {
      setState(() => _etablissements = []);
    } finally {
      setState(() => _loading = false);
    }
  }

  IconData _getIcone(String? type) {
    switch (type?.toLowerCase()) {
      case "clinique":
        return Icons.local_hospital;
      case "hopital":
      case "hôpital":
        return Icons.local_hospital;
      case "cabinet":
        return Icons.medical_services;
      default:
        return Icons.local_hospital;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Établissements"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _etablissements.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital_outlined,
                        size: 60,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Aucun établissement trouvé",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _charger,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _etablissements.length,
                    itemBuilder: (context, index) {
                      final e = _etablissements[index];
                      return Card(
                        margin: const EdgeInsets.only(
                            bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.all(14),
                          leading: Container(
                            padding:
                                const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue
                                  .withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getIcone(e["type"]),
                              color: Colors.blue,
                            ),
                          ),
                          title: Text(
                            e["nom"] ?? "Établissement",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              if (e["type"] != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  e["type"],
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                                ),
                              ],
                              if (e["adresse"] !=
                                  null) ...[
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                        width: 4),
                                    Expanded(
                                      child: Text(
                                        e["adresse"],
                                        style:
                                            const TextStyle(
                                          fontSize: 12,
                                          color:
                                              Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              if (e["telephone"] !=
                                  null) ...[
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                        width: 4),
                                    Text(
                                      e["telephone"],
                                      style:
                                          const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
