from django.contrib.auth import authenticate
from django.contrib.auth import get_user_model

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

from rest_framework_simplejwt.tokens import RefreshToken

from .models import Patient, Medecin
from rest_framework import serializers
from rest_framework import viewsets
User = get_user_model()


# =========================
# INSCRIPTION PATIENT
# =========================

from rest_framework.permissions import AllowAny
from rest_framework.decorators import permission_classes



@api_view(['POST'])
@permission_classes([AllowAny])
def register_patient(request):
    email = request.data.get('email')
    password = request.data.get('password')

    nom = request.data.get('nom')
    prenom = request.data.get('prenom')
    date_naissance = request.data.get('date_naissance')
    telephone = request.data.get('telephone')

    if User.objects.filter(email=email).exists():
        return Response(
            {"error": "Email existe déjà"},
            status=status.HTTP_400_BAD_REQUEST
        )

    user = User.objects.create_user(
        username=email,
        email=email,
        password=password,
        role="patient"
    )


    Patient.objects.create(
        user=user,
        nom=nom,
        prenom=prenom,
        date_naissance=date_naissance,
        telephone=telephone
    )

    return Response(
        {
            "message": "Patient créé avec succès",
            "email": email
        },
        status=status.HTTP_201_CREATED
    )
# =========================
# INSCRIPTION MEDECIN
# =========================

@api_view(['POST'])
@permission_classes([AllowAny])
def register_medecin(request):

    email = request.data.get('email')
    password = request.data.get('password')

    nom = request.data.get('nom')
    prenom = request.data.get('prenom')
    telephone = request.data.get('telephone')

    specialite_id = request.data.get('specialite')


    if User.objects.filter(email=email).exists():
        return Response(
            {"error": "Email existe déjà"},
            status=status.HTTP_400_BAD_REQUEST
        )


    user = User.objects.create_user(
        username=email,
        email=email,
        password=password,
        role="medecin"
    )


    Medecin.objects.create(
        user=user,
        nom=nom,
        prenom=prenom,
        telephone=telephone,
        specialite_id=specialite_id
    )


    return Response(
        {
            "message": "Médecin créé avec succès"
        },
        status=status.HTTP_201_CREATED
    )

# =========================
# LOGIN
# =========================

@api_view(['POST'])
@permission_classes([AllowAny])
def login(request):

    email = request.data.get('email')
    password = request.data.get('password')


    try:

        user = User.objects.get(
            email=email
        )

    except User.DoesNotExist:

        return Response(
            {
                "error": "Email ou mot de passe incorrect"
            },
            status=status.HTTP_401_UNAUTHORIZED
        )


    if not user.check_password(password):

        return Response(
            {
                "error": "Email ou mot de passe incorrect"
            },
            status=status.HTTP_401_UNAUTHORIZED
        )


    refresh = RefreshToken.for_user(user)


    return Response(
        {
            "refresh": str(refresh),
            "access": str(refresh.access_token),
            "email": user.email,
            "role": user.role
        }
    )
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .serializers import (
    PatientSerializer,
    MedecinSerializer,
    SpecialiteSerializer,
    EtablissementSerializer,
    DisponibiliteSerializer,
    RendezVousSerializer,
    ConsultationSerializer,
    PaiementSerializer,
    NotificationSerializer
)

from .models import (
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


# =========================
# PATIENT
# =========================


class PatientViewSet(viewsets.ModelViewSet):

    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    permission_classes = [IsAuthenticated]


    def get_queryset(self):

        user = self.request.user

        if user.role == "patient":
            return Patient.objects.filter(user=user)

        return Patient.objects.all()
# =========================
# MEDECIN
# =========================

class MedecinViewSet(viewsets.ModelViewSet):

    queryset = Medecin.objects.all()
    serializer_class = MedecinSerializer
    permission_classes = [IsAuthenticated]


    def get_queryset(self):

        user = self.request.user

        if user.role == "medecin":
            return Medecin.objects.filter(user=user)

        return Medecin.objects.all()
# =========================
# SPECIALITE
# =========================

class SpecialiteViewSet(viewsets.ModelViewSet):

    queryset = Specialite.objects.all()
    serializer_class = SpecialiteSerializer
    permission_classes = [IsAuthenticated]



# =========================
# ETABLISSEMENT
# =========================

class EtablissementViewSet(viewsets.ModelViewSet):

    queryset = Etablissement.objects.all()
    serializer_class = EtablissementSerializer
    permission_classes = [IsAuthenticated]



# =========================
# DISPONIBILITE
# =========================

class DisponibiliteViewSet(viewsets.ModelViewSet):

    queryset = Disponibilite.objects.all()

    serializer_class = DisponibiliteSerializer

    permission_classes = [IsAuthenticated]


    def get_queryset(self):

        user = self.request.user


        if user.role == "medecin":

            return Disponibilite.objects.filter(
                medecin__user=user
            )


        if user.role == "patient":

            return Disponibilite.objects.all()


        return Disponibilite.objects.none()



    def perform_create(self, serializer):

        user = self.request.user


        if user.role == "medecin":

            medecin = Medecin.objects.get(
                user=user
            )

            serializer.save(
                medecin=medecin
            )


# =========================
# RENDEZ VOUS
# =========================



from rest_framework.decorators import action
from rest_framework.response import Response

class RendezVousViewSet(viewsets.ModelViewSet):

    queryset = RendezVous.objects.all()
    serializer_class = RendezVousSerializer
    permission_classes = [IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(
            patient=self.request.user.patient
        )

    def get_queryset(self):

        user = self.request.user

        if user.role == "patient":
            return RendezVous.objects.filter(
                patient__user=user
            )

        elif user.role == "medecin":
            return RendezVous.objects.filter(
                medecin__user=user
            )

        return RendezVous.objects.none()


    @action(detail=True, methods=['post'])
    def confirmer(self, request, pk=None):

        rendezvous = self.get_object()

        rendezvous.statut = "confirme"
        rendezvous.save()

        Notification.objects.create(
            message="Votre rendez-vous est confirmé",
            statut="non_lu",
            patient=rendezvous.patient
        )

        return Response({
            "message": "Rendez-vous confirmé"
        })

    @action(detail=True, methods=['post'])
    def annuler(self, request, pk=None):

        rendezvous = self.get_object()

        rendezvous.statut = "annule"
        rendezvous.save()

        Notification.objects.create(
            message="Votre rendez-vous est annulé",
            statut="non_lu",
            patient=rendezvous.patient
        )

        return Response({
            "message": "Rendez-vous annulé"
        })
# =========================
# CONSULTATION
# =========================

class ConsultationViewSet(viewsets.ModelViewSet):

    queryset = Consultation.objects.all()

    serializer_class = ConsultationSerializer

    permission_classes = [IsAuthenticated]


    def get_queryset(self):

        user = self.request.user

        if user.role == "medecin":
            return Consultation.objects.filter(
                medecin__user=user
            )

        if user.role == "patient":
            return Consultation.objects.filter(
                rdv__patient__user=user
            )

        return Consultation.objects.none()

    def perform_create(self, serializer):

        user = self.request.user

        medecin = Medecin.objects.get(
            user=user
        )

        serializer.save(
            medecin=medecin
        )
# =========================
# PAIEMENT
# =========================

class PaiementViewSet(viewsets.ModelViewSet):

    queryset = Paiement.objects.all()
    serializer_class = PaiementSerializer
    permission_classes = [IsAuthenticated]



# =========================
# NOTIFICATION
# =========================

class NotificationViewSet(viewsets.ModelViewSet):

    queryset = Notification.objects.all()

    def get_queryset(self):

        return Notification.objects.filter(
            patient__user=self.request.user
        )
    serializer_class = NotificationSerializer
    permission_classes = [IsAuthenticated]

    def perform_update(self, serializer):

        ancien_statut = self.get_object().statut

        rendezvous = serializer.save()

        nouveau_statut = rendezvous.statut

        if ancien_statut != nouveau_statut:

            if nouveau_statut == "confirme":

                Notification.objects.create(
                    message="Votre rendez-vous est confirmé",
                    statut="non_lu",
                    patient=rendezvous.patient
                )


            elif nouveau_statut == "annule":

                Notification.objects.create(
                    message="Votre rendez-vous est annulé",
                    statut="non_lu",
                    patient=rendezvous.patient
                )