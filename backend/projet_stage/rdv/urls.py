from django.urls import path, include

from rest_framework.routers import DefaultRouter

from .views import (
    login,
    register_patient,
    register_medecin,

    PatientViewSet,
    MedecinViewSet,
    SpecialiteViewSet,
    EtablissementViewSet,
    DisponibiliteViewSet,
    RendezVousViewSet,
    ConsultationViewSet,
    PaiementViewSet,
    NotificationViewSet
)


router = DefaultRouter()


router.register(
    'patients',
    PatientViewSet
)

router.register(
    'medecins',
    MedecinViewSet
)

router.register(
    'specialites',
    SpecialiteViewSet
)

router.register(
    'etablissements',
    EtablissementViewSet
)

router.register(
    'disponibilites',
    DisponibiliteViewSet
)

router.register(
    'rendezvous',
    RendezVousViewSet
)

router.register(
    'consultations',
    ConsultationViewSet
)

router.register(
    'paiements',
    PaiementViewSet
)

router.register(
    'notifications',
    NotificationViewSet
)



urlpatterns = [

    # Authentification
    path(
        'login/',
        login
    ),

    path(
        'register/patient/',
        register_patient
    ),

    path(
        'register/medecin/',
        register_medecin
    ),


    # API CRUD
    path(
        '',
        include(router.urls)
    ),

]