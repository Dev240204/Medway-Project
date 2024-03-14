from django.contrib.auth.decorators import login_required
# Create your views here.
from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.http import HttpResponse
from django.contrib.auth.models import User
from Patient.models import *


def dashboard(request):
    
    return render(request, "Patient/patient-dashboard.html")