from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

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


admin.site.register(User, UserAdmin)

admin.site.register(Patient)
admin.site.register(Medecin)
admin.site.register(Specialite)
admin.site.register(Etablissement)
admin.site.register(Disponibilite)
admin.site.register(RendezVous)
admin.site.register(Consultation)
admin.site.register(Paiement)
admin.site.register(Notification)