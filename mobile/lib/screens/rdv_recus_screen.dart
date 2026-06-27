// // import 'package:flutter/material.dart';
// // import '../services/api_service.dart';
// // import '../theme/app_colors.dart';

// // class RdvRecusScreen extends StatefulWidget {
// //   const RdvRecusScreen({super.key});

// //   @override
// //   State<RdvRecusScreen> createState() =>
// //       _RdvRecusScreenState();
// // }

// // class _RdvRecusScreenState extends State<RdvRecusScreen> {
// //   List<dynamic> _rdvList = [];
// //   bool _loading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _chargerRdv();
// //   }

// //   Future<void> _chargerRdv() async {
// //     setState(() => _loading = true);
// //     try {
// //       final data =
// //           await ApiService.get("medecin/rendezvous/");
// //       setState(() {
// //         _rdvList = data is List ? data : [];
// //       });
// //     } catch (e) {
// //       setState(() => _rdvList = []);
// //     } finally {
// //       setState(() => _loading = false);
// //     }
// //   }

// //   Future<void> _changerStatut(
// //       int id, String statut) async {
// //     try {
// //       await ApiService.patch(
// //         "rendezvous/$id/",
// //         {"statut": statut},
// //       );
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text(
// //               statut == "confirme"
// //                   ? "Rendez-vous confirmé ✅"
// //                   : "Rendez-vous annulé ❌",
// //             ),
// //             backgroundColor: statut == "confirme"
// //                 ? Colors.green
// //                 : Colors.red,
// //           ),
// //         );
// //         _chargerRdv();
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("Erreur : $e")),
// //         );
// //       }
// //     }
// //   }

// //   Color _statutCouleur(String statut) {
// //     switch (statut) {
// //       case "confirme":
// //         return Colors.green;
// //       case "annule":
// //         return Colors.red;
// //       default:
// //         return Colors.orange;
// //     }
// //   }

// //   String _statutLabel(String statut) {
// //     switch (statut) {
// //       case "confirme":
// //         return "Confirmé";
// //       case "annule":
// //         return "Annulé";
// //       default:
// //         return "En attente";
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.background,
// //       appBar: AppBar(
// //         title: const Text("Rendez-vous Reçus"),
// //         backgroundColor: AppColors.primary,
// //         foregroundColor: Colors.white,
// //       ),
// //       body: _loading
// //           ? const Center(child: CircularProgressIndicator())
// //           : _rdvList.isEmpty
// //               ? const Center(
// //                   child: Text(
// //                     "Aucun rendez-vous reçu",
// //                     style: TextStyle(color: Colors.grey),
// //                   ),
// //                 )
// //               : RefreshIndicator(
// //                   onRefresh: _chargerRdv,
// //                   child: ListView.builder(
// //                     padding: const EdgeInsets.all(16),
// //                     itemCount: _rdvList.length,
// //                     itemBuilder: (context, index) {
// //                       final rdv = _rdvList[index];
// //                       final statut =
// //                           rdv["statut"] ?? "en_attente";

// //                       return Card(
// //                         margin: const EdgeInsets.only(
// //                             bottom: 12),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius:
// //                               BorderRadius.circular(12),
// //                         ),
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(14),
// //                           child: Column(
// //                             crossAxisAlignment:
// //                                 CrossAxisAlignment.start,
// //                             children: [
// //                               // Info patient
// //                               Row(
// //                                 children: [
// //                                   const CircleAvatar(
// //                                     backgroundColor:
// //                                         AppColors.secondary,
// //                                     child: Icon(
// //                                       Icons.person,
// //                                       color: Colors.white,
// //                                     ),
// //                                   ),
// //                                   const SizedBox(width: 10),
// //                                   Expanded(
// //                                     child: Text(
// //                                       rdv["patient_nom"] ??
// //                                           "Patient",
// //                                       style: const TextStyle(
// //                                         fontWeight:
// //                                             FontWeight.bold,
// //                                         fontSize: 16,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   Container(
// //                                     padding:
// //                                         const EdgeInsets
// //                                             .symmetric(
// //                                       horizontal: 10,
// //                                       vertical: 4,
// //                                     ),
// //                                     decoration: BoxDecoration(
// //                                       color: _statutCouleur(
// //                                         statut,
// //                                       ).withOpacity(0.1),
// //                                       borderRadius:
// //                                           BorderRadius.circular(
// //                                         20,
// //                                       ),
// //                                     ),
// //                                     child: Text(
// //                                       _statutLabel(statut),
// //                                       style: TextStyle(
// //                                         color: _statutCouleur(
// //                                           statut,
// //                                         ),
// //                                         fontSize: 12,
// //                                         fontWeight:
// //                                             FontWeight.w600,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),

// //                               const SizedBox(height: 10),
// //                               const Divider(),
// //                               const SizedBox(height: 6),

// //                               // Date et heure
// //                               Row(
// //                                 children: [
// //                                   const Icon(
// //                                     Icons.calendar_today,
// //                                     size: 16,
// //                                     color: Colors.grey,
// //                                   ),
// //                                   const SizedBox(width: 6),
// //                                   Text(
// //                                     rdv["date_rdv"] ?? "",
// //                                     style: const TextStyle(
// //                                       color: AppColors.text,
// //                                     ),
// //                                   ),
// //                                   const SizedBox(width: 16),
// //                                   const Icon(
// //                                     Icons.access_time,
// //                                     size: 16,
// //                                     color: Colors.grey,
// //                                   ),
// //                                   const SizedBox(width: 6),
// //                                   Text(
// //                                     rdv["heure_rdv"] ?? "",
// //                                     style: const TextStyle(
// //                                       color: AppColors.text,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),

// //                               // Boutons uniquement si en attente
// //                               if (statut == "en_attente") ...[
// //                                 const SizedBox(height: 12),
// //                                 Row(
// //                                   children: [
// //                                     // Bouton Confirmer
// //                                     Expanded(
// //                                       child: ElevatedButton.icon(
// //                                         onPressed: () =>
// //                                             _changerStatut(
// //                                           rdv["id"],
// //                                           "confirme",
// //                                         ),
// //                                         icon: const Icon(
// //                                           Icons.check,
// //                                           size: 18,
// //                                         ),
// //                                         label: const Text(
// //                                           "Confirmer",
// //                                         ),
// //                                         style: ElevatedButton
// //                                             .styleFrom(
// //                                           backgroundColor:
// //                                               Colors.green,
// //                                           foregroundColor:
// //                                               Colors.white,
// //                                           shape:
// //                                               RoundedRectangleBorder(
// //                                             borderRadius:
// //                                                 BorderRadius
// //                                                     .circular(8),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     const SizedBox(width: 10),
// //                                     // Bouton Annuler
// //                                     Expanded(
// //                                       child: OutlinedButton.icon(
// //                                         onPressed: () =>
// //                                             _changerStatut(
// //                                           rdv["id"],
// //                                           "annule",
// //                                         ),
// //                                         icon: const Icon(
// //                                           Icons.close,
// //                                           size: 18,
// //                                           color: Colors.red,
// //                                         ),
// //                                         label: const Text(
// //                                           "Annuler",
// //                                           style: TextStyle(
// //                                             color: Colors.red,
// //                                           ),
// //                                         ),
// //                                         style: OutlinedButton
// //                                             .styleFrom(
// //                                           side: const BorderSide(
// //                                             color: Colors.red,
// //                                           ),
// //                                           shape:
// //                                               RoundedRectangleBorder(
// //                                             borderRadius:
// //                                                 BorderRadius
// //                                                     .circular(8),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../utils/constants.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {


//   // ============================
//   // POST REQUEST
//   // ============================

//   static Future<dynamic> post(
//       String endpoint,
//       Map<String, dynamic> data
//       ) async {

//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("access");

//     final url = Uri.parse("${AppConstants.baseUrl}/$endpoint");

//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };

//     if (token != null) {
//       headers["Authorization"] = "Bearer $token";
//     }

//     final response = await http.post(
//       url,
//       headers: headers,
//       body: jsonEncode(data),
//     );

//     try {
//       return jsonDecode(response.body);
//     } catch (e) {
//       print("Erreur serveur : ${response.body}");
//       return {"error": "Erreur serveur"};
//     }

//   }


//   // ============================
//   // GET REQUEST
//   // ============================

//   static Future<dynamic> get(
//       String endpoint
//       ) async {

//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("access");

//     final url = Uri.parse("${AppConstants.baseUrl}/$endpoint");

//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };

//     if (token != null) {
//       headers["Authorization"] = "Bearer $token";
//     }

//     final response = await http.get(
//       url,
//       headers: headers,
//     );

//     return jsonDecode(response.body);

//   }


//   // ============================
//   // PATCH REQUEST
//   // ============================

//   static Future<dynamic> patch(
//       String endpoint,
//       Map<String, dynamic> data
//       ) async {

//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("access");

//     final url = Uri.parse("${AppConstants.baseUrl}/$endpoint");

//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };

//     if (token != null) {
//       headers["Authorization"] = "Bearer $token";
//     }

//     final response = await http.patch(
//       url,
//       headers: headers,
//       body: jsonEncode(data),
//     );

//     try {
//       return jsonDecode(response.body);
//     } catch (e) {
//       print("Erreur serveur : ${response.body}");
//       return {"error": "Erreur serveur"};
//     }

//   }


//   // ============================
//   // DELETE REQUEST
//   // ============================

//   static Future<dynamic> delete(
//       String endpoint
//       ) async {

//     final prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString("access");

//     final url = Uri.parse("${AppConstants.baseUrl}/$endpoint");

//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//     };

//     if (token != null) {
//       headers["Authorization"] = "Bearer $token";
//     }

//     final response = await http.delete(
//       url,
//       headers: headers,
//     );

//     if (response.body.isEmpty) {
//       return {"success": true};
//     }

//     try {
//       return jsonDecode(response.body);
//     } catch (e) {
//       return {"success": true};
//     }

//   }


// }


import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class RdvRecusScreen extends StatefulWidget {
  const RdvRecusScreen({super.key});

  @override
  State<RdvRecusScreen> createState() =>
      _RdvRecusScreenState();
}

class _RdvRecusScreenState extends State<RdvRecusScreen> {
  List<dynamic> _rdvList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _chargerRdv();
  }

  Future<void> _chargerRdv() async {
    setState(() => _loading = true);
    try {
      final data = await ApiService.get("medecin/rendezvous/");
      setState(() {
        _rdvList = data is List ? data : [];
      });
    } catch (e) {
      setState(() => _rdvList = []);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _changerStatut(int id, String statut) async {
    try {
      await ApiService.patch(
        "rendezvous/$id/",
        {"statut": statut},
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              statut == "confirme"
                  ? "Rendez-vous confirmé ✅"
                  : "Rendez-vous annulé ❌",
            ),
            backgroundColor:
                statut == "confirme" ? Colors.green : Colors.red,
          ),
        );
        _chargerRdv();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur : $e")),
        );
      }
    }
  }

  Color _statutCouleur(String statut) {
    switch (statut) {
      case "confirme":
        return Colors.green;
      case "annule":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String _statutLabel(String statut) {
    switch (statut) {
      case "confirme":
        return "Confirmé";
      case "annule":
        return "Annulé";
      default:
        return "En attente";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Rendez-vous Reçus"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _rdvList.isEmpty
              ? const Center(
                  child: Text(
                    "Aucun rendez-vous reçu",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _chargerRdv,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _rdvList.length,
                    itemBuilder: (context, index) {
                      final rdv = _rdvList[index];
                      final statut =
                          rdv["statut"] ?? "en_attente";

                      return Card(
                        margin:
                            const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:
                                        AppColors.secondary,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      rdv["patient_nom"] ??
                                          "Patient",
                                      style: const TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _statutCouleur(statut)
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _statutLabel(statut),
                                      style: TextStyle(
                                        color:
                                            _statutCouleur(statut),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(rdv["date_rdv"] ?? ""),
                                  const SizedBox(width: 16),
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(rdv["heure_rdv"] ?? ""),
                                ],
                              ),
                              if (statut == "en_attente") ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                          ElevatedButton.icon(
                                        onPressed: () =>
                                            _changerStatut(
                                          rdv["id"],
                                          "confirme",
                                        ),
                                        icon: const Icon(
                                          Icons.check,
                                          size: 18,
                                        ),
                                        label: const Text(
                                            "Confirmer"),
                                        style: ElevatedButton
                                            .styleFrom(
                                          backgroundColor:
                                              Colors.green,
                                          foregroundColor:
                                              Colors.white,
                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child:
                                          OutlinedButton.icon(
                                        onPressed: () =>
                                            _changerStatut(
                                          rdv["id"],
                                          "annule",
                                        ),
                                        icon: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Colors.red,
                                        ),
                                        label: const Text(
                                          "Annuler",
                                          style: TextStyle(
                                              color: Colors.red),
                                        ),
                                        style: OutlinedButton
                                            .styleFrom(
                                          side: const BorderSide(
                                              color: Colors.red),
                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(8),
                                          ),
                                        ),
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
