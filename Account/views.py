from django.contrib.auth.decorators import login_required
# Create your views here.
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login,logout
from django.http import HttpResponse
from Account.models import * 
# from .forms import LoginForm, SignUpForm

def receptionist_dashboard(request):
    return render(request, "Reception/receptionist-dashboard.html")

def login_view(request):
    msg = None
    context = {}

    if request.method == "POST":
        email = request.POST.get("username")
        password = request.POST.get("password")
        print(email, password)
        user = authenticate(username=email, password=password)
        print(user)
        if user is not None:
            login(request, user)
            return redirect("/receptionist-dashboard")
        else:
            context["email"] = email
            context['msg'] = 'Invalid credentials'

    return render(request, "login.html", context)


def register_user(request):
    msg = None
    success = False

    if request.method == "POST":
        username = request.POST.get("username")
        raw_password = request.POST.get("password")
        email = request.POST.get("email")
        user = User.objects.filter(username=username).first()
        if user is not None:
            return HttpResponse("User already exists")
        else:
            user = User.objects.create_user(username=username,email=email, password=raw_password)
            # user.save()
            msg = 'User created - please <a href="/login">login</a>.'
            return redirect("/receptionist-dashboard")

        success = True

    else:
        msg = 'Form is not valid'

    return render(request, "register.html")

def logout_view(request):
    logout(request)
    return redirect("/login")

