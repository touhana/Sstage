class Medecin {

  final int id;

  final String nom;

  final String prenom;

  final String telephone;

  final int? specialite;


  Medecin({

    required this.id,

    required this.nom,

    required this.prenom,

    required this.telephone,

    this.specialite,

  });


  factory Medecin.fromJson(
      Map<String, dynamic> json
      ) {

    return Medecin(

      id: json["id"],

      nom: json["nom"],

      prenom: json["prenom"],

      telephone: json["telephone"],

      specialite: json["specialite"],

    );

  }

}