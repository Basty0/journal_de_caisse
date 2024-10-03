from django.urls import path
from . import views 
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.acceuil, name='acceuil'),
    path('inscription/', views.register, name= 'inscription'),
    path('connexion/', views.login_view, name= 'connexion' ),
    path('deconnexion/', views.logOut, name="deconnexion"),
    path('personnels/', views.ajoutperso, name='personnels'),
    path('la_liste_des_personnels/', views.listePersonnels, name='personnelsliste'),
    path('la_liste_des_personnels/details/<int:id>', views.details, name='details'),
    path('la_liste_des_personnels/modifier-personnel/<int:pk>/', views.modifier_personnel, name='modifier_personnel'),
    path('la_liste_des_personnels/delete/<int:id>/', views.suppressionp, name='delete_personnel'),
    path('Catégorie/', views.categorie, name='categorie'),
    path('Fournisseur/', views.fournisseur, name='fournisseur'),
    path('Ajouts-des-Opérations/', views.ajouts_operations, name='ajout_operation'),
    path('Listes_des_Opérations/', views.listes_operations, name='listeoperation'),
    path('Ajouts_Entrer/', views.ajouter_entrer,name='ajout_entrer'),
    path('Listes_des_Opérations/modifier-entrer/<int:pk>/', views.modifier_entrer, name='modifier_entrer'),
    path('Listes_des_Opérations//delete/<int:id>/', views.suppression_entrer, name='delete_entrer'),
    path('Ajouts_Sortie/', views.ajouter_sortie,name='ajout_sortie'),
    path('Listes_des_Opérations/modifier-sortie/<int:pk>/', views.modifier_sortie, name='modifier_sortie'),
    path('Listes_des_Opérations//delete/<int:id>/', views.suppression_sortie, name='delete_sortie'),
    path('api/generer-excel/', views.generer_excel_operations, name='generer_excel_operations'),
    path('api/generer-pdf/', views.generer_pdf_operations, name='generer_pdf_operations'),


    path('export/', views.export_data, name='export_data'),
    path('import/', views.import_data, name='import_data'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)