from django.urls import path
from . import views 
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('', views.acceuil, name='acceuil'),
    path('inscription/', views.register, name= 'inscription'),
    path('connexion/', views.login_view, name= 'connexion' ),
    path('deconnexion/', views.logOut, name="deconnexion"),

    #Les urls dédier aux personnels
    path('ajouts_des_personnels/', views.ajoutperso, name='personnels'),
    path('la_liste_des_personnels/', views.listePersonnels, name='personnelsliste'),
    path('la_liste_des_personnels/details/<int:id>', views.details, name='details'),
    path('la_liste_des_personnels/modifier-personnel/<int:pk>/', views.modifier_personnel, name='modifier_personnel'),
    path('la_liste_des_personnels/delete/<int:id>/', views.suppressionp, name='delete_personnel'),

    #Catégorie
    path('Catégorie/', views.categorie, name='categorie'),

    #Fournisseur
    path('Fournisseur/', views.ajouter_fournisseur, name='fournisseur'),

    #Les pages des opérations (liste des opérations et la page pour ajouter les )
    path('Ajouts-des-Opérations/', views.ajouts_operations, name='ajout_operation'),
    path('Listes_des_Opérations/', views.listes_operations, name='listeoperation'),

    #Entrée (Ajouts, modifier, supprimer)
    path('Ajouts_Entrer/', views.ajouter_entrer,name='ajout_entrer'),
    path('Listes_des_Opérations/modifier-entrer/<int:pk>/', views.modifier_entrer, name='modifier_entrer'),
    path('Listes_des_Opérations//api/delete/<int:id>/', views.suppression_entrer, name='delete_entrer'),

    #Sortie (Ajouts, modifier, supprimer)
    path('api/Ajouts_Sortie/', views.ajouter_sortie,name='ajout_sortie'),
    path('api/Listes_des_Opérations/modifier-sortie/<int:pk>/', views.modifier_sortie, name='modifier_sortie'),
    path('api/Listes_des_Opérations//delete/<int:id>/', views.suppression_sortie, name='delete_sortie'),
    path('generer-excel/', views.generer_excel_operations, name='generer_excel_operations'),
    path('api/generer-pdf/', views.generer_pdf_operations, name='generer_pdf_operations'),

#Import et export des données
    path('export/', views.export_data, name='export_data'),
    path('import/', views.import_data, name='import_data'),

    # START: New dashboard data API endpoint
    path('api/dashboard-data/', views.dashboard_data, name='dashboard_data'),
    # END: New dashboard data API endpoint

    # Nouvelle URL pour l'API de filtrage
    path('api/filter-operations/', views.filter_operations, name='filter_operations'),

    # Nouvelles URLs pour les API
    path('api/register/', views.api_register, name='api_register'),
    path('api/login/', views.api_login, name='api_login'),
    path('api/logout/', views.api_logout, name='api_logout'),
    path('api/personnels/', views.api_personnel, name='api_personnel'),
    path('api/personnels/<int:pk>/', views.api_personnel_detail, name='api_personnel_detail'),
    path('api/categories/', views.api_categorie, name='api_categorie'),
    path('api/operations/', views.api_listes_operations, name='api_listes_operations'),
    
    # Historique pour Personnel
    path('api/personnels/<int:pk>/history/', views.historique_personnel, name='api_personnel_history'),

    # Historique pour OperationEntrer
    path('api/operations_entrer/<int:pk>/history/', views.api_operation_entrer_history, name='api_operation_entrer_history'),

    # Historique pour OperationSortir
    path('api/operations_sortir/<int:pk>/history/', views.api_operation_sortir_history, name='api_operation_sortir_history'),

    # Historique pour Categorie
    path('api/categories/<int:pk>/history/', views.api_categorie_history, name='api_categorie_history'),
    
    # Historique pour Fournisseur
    path('api/fournisseurs/<int:pk>/history/', views.api_fournisseur_history, name='api_fournisseur_history'),

    # Historique pour Beneficiaire
    path('api/beneficiaires/<int:pk>/history/', views.api_beneficiaire_history, name='api_beneficiaire_history'),

    # Historique pour Caisse
    path('api/caisses/<int:pk>/history/', views.api_caisse_history, name='api_caisse_history'),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)