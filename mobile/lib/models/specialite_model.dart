class Specialite {

  final int id;

  final String libelle;


  Specialite({

    required this.id,

    required this.libelle,

  });


  factory Specialite.fromJson(
      Map<String, dynamic> json
      ) {

    return Specialite(

      id: json["id"],

      libelle: json["libelle"],

    );

  }

}