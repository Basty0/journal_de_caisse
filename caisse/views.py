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