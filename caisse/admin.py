from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from .models import Personnel, Fournisseur, Beneficiaire, OperationEntrer, OperationSortir, CustomUser


class CustomUserAdmin(UserAdmin):
    # Tes personnalisations ici
    list_display = ('username', 'email', 'password', 'is_staff', 'is_active')
    pass
    
admin.site.register(Personnel)
admin.site.register(Fournisseur)
admin.site.register(Beneficiaire)
admin.site.register(OperationEntrer)
admin.site.register(CustomUser, CustomUserAdmin)