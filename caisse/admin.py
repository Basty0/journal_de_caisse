from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from .models import Personnel, Fournisseur, Beneficiaire, OperationEntrer, OperationSortir


class RegisterList(UserAdmin):
    list_display = ('last_name', 'first_name', 'tel', 'email')
    list_filter = ('last_name', 'first_name', 'tel', 'email')
    search_fields = ('last_name', 'first_name', 'tel', 'email')
    
admin.site.register(Personnel)
admin.site.register(Fournisseur)
admin.site.register(Beneficiaire)
admin.site.register(OperationEntrer)


class CustomUserAdmin(UserAdmin):
    # Tes personnalisations ici
    list_display = ('username', 'email', 'password', 'is_staff', 'is_active')
    pass

# Remplace l'enregistrement existant par ta version personnalisée
admin.site.unregister(User)  # Désenregistre le User existant
admin.site.register(User, CustomUserAdmin)  # Réenregistre avec des personnalisations