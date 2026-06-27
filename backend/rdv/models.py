from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):

    ROLE_CHOICES = (
        ('patient', 'Patient'),
        ('medecin', 'Medecin'),
    )

    role = models.CharField(
        max_length=20,
        choices=ROLE_CHOICES
    )

    def __str__(self):
        return self.username



class Specialite(models.Model):
    libelle = models.CharField(max_length=100)

    def __str__(self):
        return self.libelle


class Etablissement(models.Model):
    nom = models.CharField(max_length=200)
    adresse = models.CharField(max_length=300)
    telephone = models.CharField(max_length=20)
    type = models.CharField(max_length=100)

    def __str__(self):
        return self.nom


class Patient(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        related_name='patient'
    )

    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    date_naissance = models.DateField()
    telephone = models.CharField(max_length=20)

    def __str__(self):
        return f"{self.prenom} {self.nom}"


class Medecin(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        related_name='medecin'
    )

    nom = models.CharField(max_length=100)
    prenom = models.CharField(max_length=100)
    telephone = models.CharField(max_length=20)

    specialite = models.ForeignKey(
        Specialite,
        on_delete=models.SET_NULL,
        null=True
    )

    def __str__(self):
        return f"{self.prenom} {self.nom}"


class Disponibilite(models.Model):

    date_disponibilite = models.DateField()
    heure_debut = models.TimeField()
    heure_fin = models.TimeField()

    medecin = models.ForeignKey(
        Medecin,
        on_delete=models.CASCADE
    )

    def __str__(self):
        return f"{self.medecin} - {self.date_disponibilite}"
class RendezVous(models.Model):

    STATUT_CHOICES = (
        ('en_attente', 'En attente'),
        ('confirme', 'Confirmé'),
        ('annule', 'Annulé'),
    )

    date_rdv = models.DateField()
    heure_rdv = models.TimeField()

    statut = models.CharField(
        max_length=20,
        choices=STATUT_CHOICES,
        default='en_attente'
    )

    patient = models.ForeignKey(
        Patient,
        on_delete=models.CASCADE
    )

    medecin = models.ForeignKey(
        Medecin,
        on_delete=models.CASCADE
    )


class Consultation(models.Model):

    date_consultation = models.DateField()
    heure_consultation = models.TimeField()

    diagnostic = models.TextField(blank=True)
    prescription = models.TextField(blank=True)
    compte_rendu = models.TextField(blank=True)

    rdv = models.OneToOneField(
        RendezVous,
        on_delete=models.CASCADE
    )

    medecin = models.ForeignKey(
        Medecin,
        on_delete=models.CASCADE
    )

    etablissement = models.ForeignKey(
        Etablissement,
        on_delete=models.SET_NULL,
        null=True
    )


class Paiement(models.Model):

    montant = models.DecimalField(
        max_digits=10,
        decimal_places=2
    )

    date_paiement = models.DateField()

    mode_paiement = models.CharField(
        max_length=50
    )

    statut = models.CharField(
        max_length=50
    )

    rdv = models.OneToOneField(
        RendezVous,
        on_delete=models.CASCADE
    )


class Notification(models.Model):

    message = models.TextField()

    date_envoi = models.DateTimeField(
        auto_now_add=True
    )

    statut = models.CharField(
        max_length=20
    )

    patient = models.ForeignKey(
        Patient,
        on_delete=models.CASCADE
    )