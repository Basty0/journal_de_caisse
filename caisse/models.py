import re
from django.forms import ValidationError
from django.utils import timezone
from django.db import models
# Utilisation du modèle User de Django pour la gestion des utilisateurs
from django.contrib.auth.models import User
# Pour enregistrer les historiques
from simple_history.models import HistoricalRecords
from django.contrib.auth.models import AbstractUser

#Pour ajouter une colonne dans User
class CustomUser(AbstractUser):
    photo_de_profil = models.ImageField(upload_to='photos/', blank=True, default="photos/pdp_defaut.png")
    history = HistoricalRecords()
    
    def __str__(self):
        return self.username

# Modèle Category - Catégorie des transactions
class Categorie(models.Model):
    name = models.CharField(max_length=50, unique=True, default= "Mensuel")  # Nom de la catégorie (ex: Salaire, Vente, Fournitures)
    description = models.TextField(null=True, blank=True)  # Description de la catégorie
    history = HistoricalRecords()

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
    sexe = models.CharField(max_length=6, choices=SEXE_CHOICES, default='Homme')
    date_naissance = models.DateField()
    photo = models.ImageField(upload_to='photos/', blank=True , default="photos/pdp_defaut.png")
    adresse = models.CharField(max_length=100, null=True)
    type_personnel = models.CharField(max_length=10, choices=TYPE_CHOICES, null=False, default='Salarié')
    history = HistoricalRecords()

    def clean(self):

    # Validation du numéro de téléphone
        if not re.match(r'^\+?[0-9]{10,15}$', self.tel):
            raise ValidationError('Le numéro de téléphone doit comporter entre 10 et 15 chiffres.')
    
    # Validation de la date de naissance (vérifie si l'âge est raisonnable)
        if self.date_naissance >= timezone.now().date():
            raise ValidationError('La date de naissance doit être dans le passé.')

    def __str__(self):
        return f"{self.last_name} {self.first_name}"


# Modèle Fournisseur
class Fournisseur(models.Model):
    name = models.CharField(max_length=50)
    contact = models.CharField(max_length=15)  # Contact comme numéro de téléphone
    history = HistoricalRecords()

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

    name = models.CharField(max_length=50, choices=BENE_CHOICES, blank=True)
    personnel = models.ForeignKey(Personnel, on_delete=models.PROTECT, blank=True, null=True) #clé étrangère vers Personne
    history = HistoricalRecords()
    
    def __str__(self):
        # Si un name est défini, le retourner
        if self.name:
            return self.name
        # Si un personnel est défini, formater et retourner son nom complet ou toute autre propriété que tu souhaites
        elif self.personnel:
            return str(self.personnel)  # Par exemple, utiliser la méthode __str__ de l'objet Personnel
        # Si ni name ni personnel n'est défini, retourner une chaîne vide ou autre valeur par défaut

    # Méthode pour définir le nom si non défini lors de la création d'un objet
    def save(self, *args, **kwargs):
        # Si name n'est pas défini mais personnel l'est, définir name comme étant une chaîne formatée de personnel
        if not self.name and self.personnel:
            self.name = str(self.personnel)
        super(Beneficiaire, self).save(*args, **kwargs)

# Modèle pour les opérations (entrées et sorties)
# Modèle pour les entrées
class OperationEntrer(models.Model):
    
    description = models.CharField(max_length=255)  # Nom de l'opération
    montant = models.DecimalField(max_digits=10, decimal_places=0, default=5000)  # Montant
    date = models.DateField(auto_now_add=True)  # Date de l'ajout dans l'application
    date_transaction = models.DateField(default=timezone.now) # Date de l'opération
    categorie = models.ForeignKey(Categorie, on_delete=models.PROTECT, null=True)  # Clé étrangère vers Categorie
    history = HistoricalRecords()
    

    def __str__(self):
        return f"{self.description} - {self.montant}"  

# Modèle pour les soeries
class OperationSortir(models.Model):
    
    description = models.CharField(max_length=255)  # Nom de l'opération
    montant = models.DecimalField(max_digits=10, decimal_places=0, default=500)  # Montant
    date = models.DateField(auto_now_add=True)  # Date de l'ajout dans l'application
    date_de_sortie = models.DateField(default=timezone.now)
    quantité = models.DecimalField(max_digits=10, decimal_places=0, default=1)
    categorie = models.ForeignKey(Categorie, on_delete=models.PROTECT, null=False)  # Clé étrangère vers Categorie
    beneficiaire = models.ForeignKey(Beneficiaire, on_delete=models.PROTECT, null=False) #clé étrangère vers Personnel
    fournisseur = models.ForeignKey(Fournisseur, on_delete=models.PROTECT, null=False) #clé étrangère vers Fournisseur
    history = HistoricalRecords()


    def __str__(self):
        return f"{self.description} - {self.montant} - {self.beneficiaire}"   

# Modèle Caisse
class Caisse(models.Model):
    montant = models.DecimalField(max_digits=10, decimal_places=2)  # Montant en décimal pour plus de précision
    date_creation = models.DateField(auto_now_add=True)  # Date de création automatique
    history = HistoricalRecords()

    def __str__(self):
        return f"Caisse {self.id} - Montant: {self.montant}"