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
from reportlab.lib.units import inch
from reportlab.pdfgen import canvas


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

    # Récupérer le critère de tri (par défaut, tri par date)
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
        form = OperationSortirForm(request.POST)
        if form.is_valid():
            form.save()  # Sauvegarde les données dans la base de données
            return redirect('listeoperation')  # Redirige vers la liste des opérations après l
        
    else:
            form = OperationSortirForm()

    return render(request, 'ajouts_sortie.html', {'form': form})

# Modifier les sorties
def modifier_sortie(request, pk):
    sortie = get_object_or_404(OperationSortir, pk=pk)  # Récupère l'objet existant dans entrer
    if request.method == 'POST':
        form = OperationSortirForm(request.POST, request.FILES, instance=sortie)  # Charge les données POST
        if form.is_valid():
            form.save()  # Sauvegarde les modifications
            return redirect('listeoperation')  # Redirige vers la liste des opérations (corrigez selon votre URL pattern)
    else:
        form = OperationEntrerForm(instance=sortie)  # Formulaire pré-rempli avec les données actuelles

    return render(request, 'modifier_sortie.html', {'form': form, 'sortie': sortie})

# Supprimer une opération
def suppression_sortie(request, id):
    if request.method == 'POST':
        suppr = OperationSortir.objects.get(pk=id)
        suppr.delete()
        return redirect('listeoperation')
    
#Pour générer un rapport en EXCEL (.xlsx)
def generer_excel_operations(request):
    # Créer un nouveau classeur Excel
    workbook = openpyxl.Workbook()
    sheet = workbook.active
    sheet.title = "Liste des Opérations"

    # Définir les en-têtes
    headers = ["Type", "Description", "Catégorie", "Bénéficiaire", "Fournisseurs", "Date", "Quantité", "Montant"]
    sheet.append(headers)

     # Appliquer un style aux en-têtes
    for col in sheet.iter_cols(min_row=1, max_row=1, min_col=1, max_col=len(headers)):
        for cell in col:
            cell.font = Font(bold=True, color="FFFFFF")
            cell.alignment = Alignment(horizontal="center")
            cell.fill = openpyxl.styles.PatternFill("solid", fgColor="4F81BD")  # Fond bleu

     # Style des bordures
    thin_border = Border(left=Side(style='thin'), right=Side(style='thin'),
                         top=Side(style='thin'), bottom=Side(style='thin'))

    # Récupérer les données de la base de données
    def ajouter_operations(operations, type_operation, avec_beneficiaire=False):
        """Ajouter des opérations au fichier Excel."""
        for operation in operations:
            # Vérifier si l'opération a un bénéficiaire ou un fournisseur
            beneficiaire = operation.beneficiaire.name if avec_beneficiaire else "N/A"
            fournisseur = operation.fournisseur.name if avec_beneficiaire else "N/A"
            quantite = operation.quantité if avec_beneficiaire else "N/A"
            sheet.append([type_operation, operation.description, operation.categorie.name, beneficiaire, fournisseur, operation.date, quantite, operation.montant])

    # Ajouter les opérations d'entrée et de sortie
    ajouter_operations(OperationEntrer.objects.all(), "Entrée")
    ajouter_operations(OperationSortir.objects.all(), "Sortie", avec_beneficiaire=True)

     # Ajuster automatiquement la largeur des colonnes
    for column_cells in sheet.columns:
        length = max(len(str(cell.value)) for cell in column_cells)
        sheet.column_dimensions[column_cells[0].column_letter].width = length + 2

    # Créer un tableau structuré
    tableau = Table(displayName="TableauOperations", ref=f"A1:G{sheet.max_row}")
    style = TableStyleInfo(name="TableStyleMedium9", showFirstColumn=False,
                           showLastColumn=False, showRowStripes=True, showColumnStripes=True)
    tableau.tableStyleInfo = style
    sheet.add_table(tableau)

     # Obtenir la date et l'heure actuelles
    now = datetime.now().strftime('%d-%m-%Y_%H-%M')
    
    # Créer la réponse HTTP pour le fichier Excel
    filename = f"Rapport_de_{now}.xlsx"
    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    response['Content-Disposition'] = f'attachment; filename="{filename}"'

    # Enregistrer le fichier Excel dans la réponse HTTP
    workbook.save(response)
    
    return response


def generer_pdf_operations(request):
    # Créer la réponse HTTP pour le fichier PDF
    response = HttpResponse(content_type='application/pdf')
    
    # Obtenir la date et l'heure actuelles pour inclure dans le nom du fichier
    now = datetime.now().strftime('%d-%m-%Y_%H-%M')
    filename = f"Rapport_de_{now}.pdf"
    response['Content-Disposition'] = f'attachment; filename="{filename}"'

    # Créer un objet canvas pour le fichier PDF
    p = canvas.Canvas(response, pagesize=A4)
    p.setTitle("Rapport des Opérations")

    # Variables pour la mise en page
    width, height = A4
    y_position = height - 50  # Position initiale (top de la page)
    line_height = 14  # Hauteur entre les lignes

    # Ajouter le titre du rapport
    p.setFont("Helvetica-Bold", 16)
    p.drawString(100, y_position, f"Rapport des Opérations - {now}")
    y_position -= 40

    # Fonction pour ajouter les informations d'une opération
    def ajouter_operation(type_operation, description, categorie, beneficiaire, fournisseur, date, quantite, montant):
        nonlocal y_position
        p.setFont("Helvetica-Bold", 12)
        p.drawString(40, y_position, f"Type d'opération: {type_operation}")
        y_position -= line_height

        p.setFont("Helvetica", 10)
        p.drawString(60, y_position, f"Description : {description}")
        y_position -= line_height
        p.drawString(60, y_position, f"Catégorie : {categorie}")
        y_position -= line_height
        p.drawString(60, y_position, f"Bénéficiaire : {beneficiaire}")
        y_position -= line_height
        p.drawString(60, y_position, f"Fournisseur : {fournisseur}")
        y_position -= line_height
        p.drawString(60, y_position, f"Date : {date}")
        y_position -= line_height
        p.drawString(60, y_position, f"Quantité : {quantite}")
        y_position -= line_height
        p.drawString(60, y_position, f"Montant : {montant}")
        y_position -= 2 * line_height  # Ajouter un espace après chaque opération

    # Récupérer et ajouter les opérations d'entrée
    p.setFont("Helvetica-Bold", 14)
    p.drawString(40, y_position, "Opérations d'Entrée")
    y_position -= 20

    operations_entrer = OperationEntrer.objects.all()
    for operation in operations_entrer:
        ajouter_operation(
            type_operation="Entrée",
            description=operation.description,
            categorie=operation.categorie.name,
            beneficiaire="N/A",  # Pas de bénéficiaire pour les entrées
            fournisseur="N/A",  # Pas de fournisseur pour les entrées
            date=operation.date.strftime('%d-%m-%Y'),
            quantite="N/A",  # Pas de quantité pour les entrées
            montant=f"{operation.montant} Ar"
        )

    # Récupérer et ajouter les opérations de sortie
    p.setFont("Helvetica-Bold", 14)
    p.drawString(40, y_position, "Opérations de Sortie")
    y_position -= 20

    operations_sortir = OperationSortir.objects.all()
    for operation in operations_sortir:
        ajouter_operation(
            type_operation="Sortie",
            description=operation.description,
            categorie=operation.categorie.name,
            beneficiaire=operation.beneficiaire.name if operation.beneficiaire else "N/A",
            fournisseur=operation.fournisseur.name if operation.fournisseur else "N/A",
            date=operation.date.strftime('%d-%m-%Y'),
            quantite=operation.quantité if operation.quantité else "N/A",
            montant=f"{operation.montant} Ar"
        )

    # Finaliser et enregistrer le PDF
    p.showPage()
    p.save()

    return response