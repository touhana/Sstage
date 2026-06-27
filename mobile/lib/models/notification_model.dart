class NotificationModel {


  final int id;

  final String message;

  final String dateEnvoi;

  final String statut;



  NotificationModel({

    required this.id,

    required this.message,

    required this.dateEnvoi,

    required this.statut,

  });



  factory NotificationModel.fromJson(
      Map<String,dynamic> json
      ){

    return NotificationModel(

      id: json["id"],

      message: json["message"],

      dateEnvoi: json["date_envoi"],

      statut: json["statut"],

    );

  }

}