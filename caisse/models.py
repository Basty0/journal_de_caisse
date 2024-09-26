import re
from django.forms import ValidationError
from django.utils import timezone
from django.db import models
# Utilisation du modèle User de Django pour la gestion des utilisateurs
from django.contrib.auth.models import User


# Modèle Category - Catégorie des transactions
class Categorie(models.Model):
    name = models.CharField(max_length=100, null=True, default= "Mensuel")  # Nom de la catégorie (ex: Salaire, Vente, Fournitures)
    description = models.TextField(null=True, blank=True)  # Description de la catégorie

    def __str__(self):
        return self.name

# Modèle Personnel
class Personnel(models.Model):
     # Sexe
    HOMME = 'Homme'
    FEMME = 'Femme'
    SEXE_CHOICES = [
        (HOMME, 'Homme'),
        (FEMME, 'Femme'),
    ]

     # Type d'employé
    S = 'Salarié'
    B = 'Bénévole'
    F = 'Freelance'
    ST = 'Stagiaire'
    TYPE_CHOICES = [
        (S, 'Salarié'),
        (B, 'Bénévole'),
        (F, 'Freelance'),
        (ST, 'Stagiaire'),
    ]
    last_name = models.CharField(max_length=50)
    first_name = models.CharField(max_length=50)
    tel = models.CharField(max_length=15, default="+261")
    email = models.EmailField()
    date_embauche = models.DateTimeField(default=timezone.now)
    sexe = models.CharField(max_length=5, choices=SEXE_CHOICES, default='T')
    date_naissance = models.DateField()
    photo = models.ImageField(upload_to='photos/', blank=True , default="photos/pdp_defaut.png")
    adresse = models.CharField(max_length=100, null=True)
    type_personnel = models.CharField(max_length=10, choices=TYPE_CHOICES, null=True)

    def clean(self):

      # Validation du numéro de téléphone
        if not re.match(r'^\+?[0-9]{10,15}$', self.tel):
            raise ValidationError('Le numéro de téléphone doit comporter entre 10 et 15 chiffres.')
    
    # Validation de la date de naissance (vérifie si l'âge est raisonnable)
        if self.date_naissance >= timezone.now().date():
            raise ValidationError('La date de naissance doit être dans le passé.')

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


# Modèle Fournisseur
class Fournisseur(models.Model):
    name = models.CharField(max_length=50)
    contact = models.CharField(max_length=15)  # Contact comme numéro de téléphone

    def __str__(self):
        return self.name


# Modèle Beneficiaire
class Beneficiaire(models.Model):
#benéficiaire
    C = 'Cuisine'
    T = 'Toilette'
    M = 'Moto'

    BENE_CHOICES = [
        (C, 'Cuisine'),
        (T, 'Toilette'),
        (M, 'Moto'),
    ]

    name = models.CharField(max_length=50, choices=BENE_CHOICES, null=True)
    personnel = models.ForeignKey(Personnel, on_delete=models.SET_NULL, null=True) #clé étrangère vers Personne

    def __str__(self):
        return self.name

# Modèle pour les opérations (entrées et sorties)
# Modèle pour les entrées
class OperationEntrer(models.Model):
    
    description = models.CharField(max_length=255)  # Nom de l'opération
    montant = models.DecimalField(max_digits=10, decimal_places=0, default=5000)  # Montant
    date = models.DateField(auto_now_add=True)  # Date de l'ajout dans l'application
    date_transaction = models.DateField(default=timezone.now) # Date de l'opération
    categorie = models.ForeignKey(Categorie, on_delete=models.SET_NULL, null=True)  # Clé étrangère vers Categorie
    

    def __str__(self):
        return f"{self.description} - {self.montant}"  
         

# Modèle pour les soeries
class OperationSortir(models.Model):
    
    description = models.CharField(max_length=255)  # Nom de l'opération
    montant = models.DecimalField(max_digits=10, decimal_places=2, default=500)  # Montant
    date = models.DateField(auto_now_add=True)  # Date de l'ajout dans l'application
    date_de_sortie = models.DateField(default=timezone.now)
    quantité = models.DecimalField(max_digits=10, decimal_places=0, default=1)
    Categorie = models.ForeignKey(Categorie, on_delete=models.CASCADE, null=False)  # Clé étrangère vers Categorie
    beneficiaire = models.ForeignKey(Beneficiaire, on_delete=models.CASCADE, null=False) #clé étrangère vers Personnel
    fournisseur = models.ForeignKey(Fournisseur, on_delete=models.CASCADE, null=False) #clé étrangère vers Fournisseur


    def __str__(self):
        return f"{self.description} - {self.montant}"   

# Modèle Caisse
class Caisse(models.Model):
    montant = models.DecimalField(max_digits=10, decimal_places=2)  # Montant en décimal pour plus de précision
    date_creation = models.DateField(auto_now_add=True)  # Date de création automatique

    def __str__(self):
        return f"Caisse {self.id} - Montant: {self.montant}"

# Modèle Role - Pour les rôles des utilisateurs (ex : Admin, Manager, Utilisateur)
class Role(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


# Modèle Permission - Gestion des permissions
class Permission(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name


# Modèle Admin (héritant potentiellement de User si besoin)
class Admin(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    # Champ d'image pour la photo de profil, il faut d'abord installer pillow avec pip
    pdp = models.ImageField(upload_to='profile_pics/', null=True, blank=True)  

    def __str__(self):
        return self.user.username