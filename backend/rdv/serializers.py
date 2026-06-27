from rest_framework import serializers

from .models import (
    User,
    Patient,
    Medecin,
    Specialite,
    Etablissement,
    Disponibilite,
    RendezVous,
    Consultation,
    Paiement,
    Notification
)


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = [
            "id",
            "username",
            "email",
            "role"
        ]



class PatientSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)

    class Meta:
        model = Patient
        fields = [
            "id",
            "user",
            "nom",
            "prenom",
            "date_naissance",
            "telephone"
        ]



class MedecinSerializer(serializers.ModelSerializer):

    user = UserSerializer(read_only=True)

    class Meta:
        model = Medecin
        fields = [
            "id",
            "user",
            "nom",
            "prenom",
            "telephone",
            "specialite"
        ]



class SpecialiteSerializer(serializers.ModelSerializer):

    class Meta:
        model = Specialite
        fields = "__all__"



class EtablissementSerializer(serializers.ModelSerializer):

    class Meta:
        model = Etablissement
        fields = "__all__"



class DisponibiliteSerializer(serializers.ModelSerializer):

    class Meta:
        model = Disponibilite
        fields = [
            "id",
            "date_disponibilite",
            "heure_debut",
            "heure_fin"
        ]

class RendezVousSerializer(serializers.ModelSerializer):

    class Meta:

        model = RendezVous

        fields = [
            "id",
            "date_rdv",
            "heure_rdv",
            "statut",
            "medecin"
        ]

        read_only_fields = [
            "statut"
        ]
class ConsultationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Consultation

        fields = [
            "id",
            "date_consultation",
            "heure_consultation",
            "diagnostic",
            "prescription",
            "compte_rendu",
            "rdv",
            "medecin",
            "etablissement"
        ]

        read_only_fields = [
            "medecin"
        ]
class PaiementSerializer(serializers.ModelSerializer):

    class Meta:
        model = Paiement
        fields = "__all__"



class NotificationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Notification
        fields = "__all__"