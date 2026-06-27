class RendezVous {


  final int? id;

  final String dateRdv;

  final String heureRdv;

  final String statut;

  final int medecin;



  RendezVous({

    this.id,

    required this.dateRdv,

    required this.heureRdv,

    required this.statut,

    required this.medecin,

  });



  factory RendezVous.fromJson(
      Map<String, dynamic> json
      ) {


    return RendezVous(

      id: json["id"],

      dateRdv:
          json["date_rdv"],

      heureRdv:
          json["heure_rdv"],

      statut:
          json["statut"],

      medecin:
          json["medecin"],

    );


  }

}