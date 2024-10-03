from django.shortcuts import render, redirect, get_object_or_404, HttpResponseRedirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .forms import LoginForm, PersonnelForm, OperationEntrerForm, CategorieForm, FournisseurForm, OperationSortirForm
from .models import Personnel, OperationEntrer, Categorie, OperationSortir, Fournisseur, Beneficiaire
from django.http import HttpResponse, JsonResponse
from django.template import loader
from django.db.models import Q
import openpyxl
from openpyxl.styles import Font, Alignment, Border, Side
from openpyxl.worksheet.table import Table, TableStyleInfo
from datetime import datetime # Importer datetime pour obtenir la date et l'heure actuelles
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from reportlab.lib.units import inch
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph
from reportlab.pdfgen import canvas
from django.core.management import call_command
from django.core.files.storage import default_storage
from django.core.files.base import ContentFile
import os
from reportlab.lib.styles import getSampleStyleSheet
from django.contrib.auth.decorators import permission_required
from rest_framework.response import Response
from rest_framework.decorators import api_view


#Pour forcé la connexion avant d'aller dans l'acceuil
@login_required(login_url='connexion/')
def acceuil(request):
    return render(request, 'acceuil.html',)

def register(request):
    if request.method == 'POST':
        username = request.POST['username']
        email = request.POST['email']
        password = request.POST['password']
        new_user = User.objects.create_user(username=username, email=email, password=password)
        #new_user.is_staff = True
        new_user.save()
        return redirect('connexion')

    return render(request, 'inscription.html')

#def logIn(request):
def login_view(request):
    if request.method == 'POST':
        form = LoginForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                return render(request, 'acceuil.html')  # Redirection vers la page d'accueil après connexion
    else:
        form = LoginForm()
    
    return render(request, 'connexion.html', {'form': form})
 #if request.method == 'POST':
           # username = request.POST['username']
            #password = request.POST['password']
           # user = authenticate(username=username, password=password)
            #if user is not None:
             #   login(request, user)
              #  return render(request, 'acceuil.html')
            #else:
             #   messages.error(request,'Identifiant ou mot de passe incorrect')
              #  return redirect('connexion')
            
# return render(<request, 'connexion.html')

def logOut(request):
    logout(request)
    return redirect('acceuil')

#def ajoutperso(request):
    # return render(request, 'personnels.html')

# Pour voir la liste des personnel
def listePersonnels(request):
    query = request.GET.get('q')  # Récupérer le terme de recherche depuis l'URL
    if query:
        personnels = Personnel.objects.filter(
            Q(last_name__icontains=query) | 
            Q(first_name__icontains=query) | 
            Q(email__icontains=query) |
            Q(type_personnel__icontains=query)
        )  # Filtrer les résultats selon le terme de recherche
    else:
        personnels = Personnel.objects.all()

    if personnels.exists():
        template = loader.get_template('listePersonnels.html')
        context = {
            'personnels': personnels,
        }
        return HttpResponse(template.render(context, request))
    else:
        # Gérer le cas où aucun personnel n'est trouvé
        return HttpResponse("Aucun personnel trouvé avec ce critère de recherche.")

def ajoutperso(request):
    if request.method == 'POST':
        form = PersonnelForm(request.POST)
        if form.is_valid():
            form.save()  # Sauvegarde les données dans la base de données
            return redirect('personnelsliste')  # Redirige vers la liste des personnels après l'ajout
    else:
        form = PersonnelForm()

    return render(request, 'personnels.html', {'form': form})

#Les informations sur le personnel choisi
def details(request, id):
  x = Personnel.objects.get(id=id)
  template = loader.get_template('detailsperso.html')
  context = {'x': x,}
  return HttpResponse(template.render(context, request))    

def modifier_personnel(request, pk):
    personnels = get_object_or_404(Personnel, pk=pk)  # Récupère l'objet existant
    if request.method == 'POST':
        form = PersonnelForm(request.POST, request.FILES, instance=personnels)  # Charge les données POST
        if form.is_valid():
            form.save()  # Sauvegarde les modifications
            return redirect('details', personnels.pk)  # Redirige vers la page de détail du personnel
    else:
        form = PersonnelForm(instance=personnels)  # Formulaire pré-rempli avec les données actuelles

    return render(request, 'modifier_personnel.html', {'form': form})

# Supprimer un personnel
def suppressionp(request, id):
    if request.method == 'POST':
        suppr = Personnel.objects.get(pk=id)
        suppr.delete()
        return redirect('personnelsliste')

def listes_operations(request):
    # Récupérer les filtres de recherche et de triage
    query = request.GET.get('q')
    categorie_id = request.GET.get('categorie')
    beneficiaire_id = request.GET.get('beneficiaire')
    fournisseur_id = request.GET.get('fournisseur')
    montant_min = request.GET.get('montant_min')
    montant_max = request.GET.get('montant_max')
    date_min = request.GET.get('date_min')
    date_max = request.GET.get('date_max')
    quantite_min = request.GET.get('quantite_min')
    quantite_max = request.GET.get('quantite_max')

   
    sort_by = request.GET.get('sort', 'date')  # Trier par date par défaut

    # Filtrer les opérations d'entrée
    entree = OperationEntrer.objects.all()
    sortie = OperationSortir.objects.all()

    if query:
        # Filtrer les résultats selon le terme de recherche
        entree = OperationEntrer.objects.filter(
            Q(description__icontains=query) | 
            Q(categorie__name__icontains=query) |
            Q(montant__icontains=query) | 
            Q(date__icontains=query)
        )  
        sortie = OperationSortir.objects.filter(
            Q(description__icontains=query) | 
            Q(categorie__name__icontains=query) |
            Q(montant__icontains=query) | 
            Q(date__icontains=query)
        )
    if categorie_id:
        entree = entree.filter(categorie_id=categorie_id)
        sortie = sortie.filter(categorie_id=categorie_id)

    if beneficiaire_id:
        sortie = sortie.filter(beneficiaire_id=beneficiaire_id)

    if fournisseur_id:
        sortie = sortie.filter(fournisseur_id=fournisseur_id)

    if montant_min:
        entree = entree.filter(montant__gte=montant_min)
        sortie = sortie.filter(montant__gte=montant_min)

    if montant_max:
        entree = entree.filter(montant__lte=montant_max)
        sortie = sortie.filter(montant__lte=montant_max)

    if date_min:
        entree = entree.filter(date__gte=date_min)
        sortie = sortie.filter(date__gte=date_min)

    if date_max:
        entree = entree.filter(date__lte=date_max)
        sortie = sortie.filter(date__lte=date_max)

    if quantite_min:
        sortie = sortie.filter(quantité__gte=quantite_min)

    if quantite_max:
        sortie = sortie.filter(quantité__lte=quantite_max)

    # Appliquer le triage sur les opérations (catégorie, bénéficiaire, fournisseur, montant, date, quantité)
    entree = entree.order_by(sort_by)
    sortie = sortie.order_by(sort_by)

    # Appliquer le triage sur les opérations (catégorie, bénéficiaire, fournisseur, montant, date, quantité)
    entree = entree.order_by(sort_by)
    sortie = sortie.order_by(sort_by)

    # Récupérer les catégories, bénéficiaires et fournisseurs pour les options de filtrage
    categories = Categorie.objects.all()
    beneficiaires = Beneficiaire.objects.all()
    fournisseurs = Fournisseur.objects.all()
    template = loader.get_template('listeopération.html')

    context = {
        'entree': entree,
        'sortie': sortie,
        'categories': categories,
        'beneficiaires': beneficiaires,
        'fournisseurs': fournisseurs,
        'prix': "Ar",
        'sort_by': sort_by,
    }
    return HttpResponse(template.render(context, request))

#Ajouter un catégorie 
def categorie(request):
    if request.method == 'POST':
        form = CategorieForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('acceuil')
    else:
        form = CategorieForm()
    return render(request, 'categorie.html', {'form': form})

#Ajouter un fournisseur
def fournisseur(request):
    if request.method == 'POST':
        form = FournisseurForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('acceuil')
    else:
        form = FournisseurForm()
    return render(request, 'fournisseur.html', {'form': form})

# Une page pour ajouter une opération

def ajouts_operations(request):
    return render(request, 'ajout_operation.html',)

# Ajouter Entrer
def ajouter_entrer(request):
    if request.method == 'POST':
        form = OperationEntrerForm(request.POST)
        if form.is_valid():
            form.save()  # Sauvegarde les données dans la base de données
            return redirect('listeoperation')  # Redirige vers la liste des opérations après l
        
    else:
            form = OperationEntrerForm()

    return render(request, 'ajouts_entrer.html', {'form': form})

# Supprimer une opération
def suppression_entrer(request, id):
    if request.method == 'POST':
        suppr = OperationEntrer.objects.get(pk=id)
        suppr.delete()
        return redirect('listeoperation')

# modifier les entrées
def modifier_entrer(request, pk):
    entree = get_object_or_404(OperationEntrer, pk=pk)  # Récupère l'objet existant dans entrer
    if request.method == 'POST':
        form = OperationEntrerForm(request.POST, request.FILES, instance=entree)  # Charge les données POST
        if form.is_valid():
            form.save()  # Sauvegarde les modifications
            return redirect('listeoperation')  # Redirige vers la liste des opérations (corrigez selon votre URL pattern)
    else:
        form = OperationEntrerForm(instance=entree)  # Formulaire pré-rempli avec les données actuelles

    return render(request, 'modifier_entrer.html', {'form': form, 'entree': entree})

# Ajouter Sortie
def ajouter_sortie(request):
    if request.method == 'POST':
        try:
            form = OperationSortirForm(request.POST)
            if form.is_valid():
                form.save()  # Sauvegarde les données dans la base de données
                return JsonResponse({"status": "success", "message": "La sortie a été ajoutée avec succès."})
            else:
                return JsonResponse({"status": "error", "message": "Les données du formulaire ne sont pas valides."})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)})
    else:
        return JsonResponse({"status": "error", "message": "La méthode HTTP doit être POST."})
    
# Modifier les sorties
def modifier_sortie(request, pk):
    try:
        sortie = get_object_or_404(OperationSortir, pk=pk)  # Récupère l'objet existant
        if request.method == 'POST':
            form = OperationSortirForm(request.POST, request.FILES, instance=sortie)
            if form.is_valid():
                form.save()  # Sauvegarde les modifications
                return JsonResponse({"status": "success", "message": "La sortie a été modifiée avec succès."})
            else:
                return JsonResponse({"status": "error", "message": "Les données du formulaire ne sont pas valides."})
        else:
            return JsonResponse({"status": "error", "message": "La méthode HTTP doit être POST."})
    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)})
    
#Suppression des sorties
def suppression_sortie(request, id):
    try:
        # Rechercher l'opération à supprimer
        suppr = OperationSortir.objects.get(pk=id)
        
        # Supprimer l'opération
        suppr.delete()

        # Retourner une réponse JSON indiquant que la suppression a réussi
        return JsonResponse({"status": "success", "message": "L'opération a été supprimée avec succès."})

    except OperationSortir.DoesNotExist:
        # Retourner une réponse JSON indiquant que l'opération n'existe pas
        return JsonResponse({"status": "error", "message": "L'opération n'existe pas."})

    except Exception as e:
        # En cas d'erreur générale, retourner une réponse JSON avec le message d'erreur
        return JsonResponse({"status": "error", "message": str(e)})
    
#Pour générer un rapport en EXCEL (.xlsx)
def generer_excel_operations(request):
    # Créer un nouveau classeur Excel
    workbook = openpyxl.Workbook()
    sheet = workbook.active
    sheet.title = "Liste des Opérations"

    # Définir les en-têtes
    headers = ["Type", "Description", "Montant", "Date", "Bénéficiaire", "Fournisseur", "Quantité"]
    sheet.append(headers)

    def ajouter_operations(operations, type_operation, avec_beneficiaire=False):
        """Ajouter des opérations au fichier Excel."""
        for operation in operations:
            beneficiaire = operation.beneficiaire.name if avec_beneficiaire else "N/A"
            fournisseur = operation.fournisseur.name if avec_beneficiaire else "N/A"
            quantite = operation.quantité if avec_beneficiaire else "N/A"
            row = [type_operation, operation.description, operation.montant, operation.date, beneficiaire, fournisseur, quantite]
            sheet.append(row)

    # Ajouter les opérations d'entrée et de sortie
    ajouter_operations(OperationEntrer.objects.all(), "Entrée")
    ajouter_operations(OperationSortir.objects.all(), "Sortie", avec_beneficiaire=True)

    # Obtenir la date et l'heure actuelles
    now = datetime.now().strftime('%d-%m-%Y_%H-%M')

    # Créer la réponse HTTP pour le fichier Excel avec date et heure dans le nom du fichier
    filename = f"rapport_operations_{now}.xlsx"
    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    response['Content-Disposition'] = f'attachment; filename="{filename}"'

    # Enregistrer le fichier Excel dans la réponse HTTP
    workbook.save(response)
    
    return response
    
#Pour générer un rapport en PDF (.pdf)
def generer_pdf_operations(request):
    try:
        # Créer la réponse HTTP pour le fichier PDF
        response = HttpResponse(content_type='application/pdf')

        # Obtenir la date et l'heure actuelles pour inclure dans le nom du fichier
        now = datetime.now().strftime('%d-%m-%Y_%H-%M')
        filename = f"Rapport_de_{now}.pdf"
        response['Content-Disposition'] = f'attachment; filename="{filename}"'

        # Créer un document PDF
        pdf = SimpleDocTemplate(response, pagesize=A4)
        elements = []

        # Obtenir un style pour les paragraphes
        styles = getSampleStyleSheet()
        style_normal = styles['Normal']

        # Définir les en-têtes du tableau
        headers = ["Type", "Description", "Catégorie", "Bénéficiaire", "Fournisseur", "Date", "Quantité", "Montant"]

        # Récupérer les données des opérations d'entrée et de sortie
        data = [headers]  # Le tableau commence par les en-têtes

        # Récupérer et ajouter les opérations d'entrée
        operations_entrer = OperationEntrer.objects.all()
        for operation in operations_entrer:
            data.append([
                "Entrée",
                Paragraph(operation.description, style_normal),  # Retour à la ligne dans la description
                Paragraph(operation.categorie.name, style_normal),
                "N/A",  # Pas de bénéficiaire pour les entrées
                "N/A",  # Pas de fournisseur pour les entrées
                Paragraph(operation.date.strftime('%d-%m-%Y'), style_normal),
                "N/A",  # Pas de quantité pour les entrées
                f"{operation.montant} Ar"
            ])

        # Récupérer et ajouter les opérations de sortie
        operations_sortir = OperationSortir.objects.all()
        for operation in operations_sortir:
            data.append([
                "Sortie",
                Paragraph(operation.description, style_normal),  # Retour à la ligne dans la description
                Paragraph(operation.categorie.name, style_normal),
                Paragraph(operation.beneficiaire.name if operation.beneficiaire else "N/A", style_normal),
                Paragraph(operation.fournisseur.name if operation.fournisseur else "N/A", style_normal),
                Paragraph(operation.date.strftime('%d-%m-%Y'), style_normal),
                operation.quantité if operation.quantité else "N/A",
                f"{operation.montant} Ar"
            ])

        # Créer un tableau avec les données
        tableau = Table(data, colWidths=[1 * inch] * len(headers))

        # Appliquer un style au tableau
        tableau.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor("#4F81BD")),  # Couleur de fond des en-têtes
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),  # Couleur du texte des en-têtes
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),  # Texte en gras pour les en-têtes
            ('BOTTOMPADDING', (0, 0), (-1, 0), 12),  # Ajout d'espace pour les en-têtes
            ('GRID', (0, 0), (-1, -1), 1, colors.black),  # Bordures pour tout le tableau
            ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.whitesmoke, colors.lightgrey]),  # Alternance des lignes
        ]))

        # Ajouter le tableau à la liste d'éléments du PDF
        elements.append(tableau)

        # Construire le document PDF
        pdf.build(elements)

        return response

    except Exception as e:
        # En cas d'erreur, retourner un JSON avec un message d'erreur
        return JsonResponse({"status": "error", "message": str(e)})


# Vue pour exporter les données (sauvegarde)
def export_data(request):
    # Chemin du fichier de sauvegarde
    file_path = 'backup.json'

    # Exécuter la commande dumpdata pour sauvegarder toutes les données
    with open(file_path, 'w') as f:
        call_command('dumpdata', format='json', indent=4, stdout=f)

    # Lire le fichier de sauvegarde et renvoyer comme réponse HTTP
    with open(file_path, 'rb') as f:
        response = HttpResponse(f.read(), content_type='application/json')
        response['Content-Disposition'] = 'attachment; filename=backup.json'
    
    # Supprimer le fichier après téléchargement
    os.remove(file_path)

    return response

# Vue pour importer les données (restauration)
def import_data(request):
    if request.method == 'POST' and 'backup_file' in request.FILES:
        # Récupérer le fichier téléchargé
        backup_file = request.FILES['backup_file']

        # Enregistrer temporairement le fichier JSON
        file_path = default_storage.save('temp_backup.json', ContentFile(backup_file.read()))

        # Charger les données dans la base de données en utilisant la commande loaddata
        try:
            call_command('loaddata', file_path)
            message = "Les données ont été restaurées avec succès."
        except Exception as e:
            message = f"Erreur lors de la restauration des données: {str(e)}"
        
        # Supprimer le fichier temporaire
        default_storage.delete(file_path)

        return HttpResponse(message)

    return render(request, 'import_data.html')