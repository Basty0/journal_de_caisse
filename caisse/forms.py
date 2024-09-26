from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from .models import Personnel, OperationEntrer, Categorie, OperationSortir, Fournisseur


#class RegisterForm(UserCreationForm):
    #email = forms.EmailField(label="Email", required=True)

   # class Meta:
        #model = User
        #fields = ('username', 'email', 'password1', 'password2')
        
class LoginForm(AuthenticationForm):
    username = forms.CharField(label="Nom d'utilisateur", max_length=100)
    password = forms.CharField(widget=forms.PasswordInput, label="Mot de passe")

class CategorieForm(forms.ModelForm):
    class Meta:
        model = Categorie
        fields = '__all__'

class PersonnelForm(forms.ModelForm):
    
    class Meta:
        model = Personnel
        fields = '__all__'

class OperationEntrerForm(forms.ModelForm):
    class Meta:
        model = OperationEntrer
        fields = '__all__'

class OperationSortirForm(forms.ModelForm):
    class Meta:
        model = OperationSortir
        fields = '__all__'

class FournisseurForm(forms.ModelForm):
    class Meta:
        model = Fournisseur
        fields = '__all__'