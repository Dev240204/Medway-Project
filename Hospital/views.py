from django.contrib.auth.decorators import login_required
# Create your views here.
from django.shortcuts import render, redirect
from django.core import serializers
from django.contrib.auth import authenticate, login
from django.http import HttpResponse
from django.core.serializers.json import DjangoJSONEncoder
from django.contrib.auth.models import User
from Doctor.models import *
from Appointment.models import *
import json 

def dashboard(request):
    doctors = Doctor.objects.all()
    context = {'user': request.user, 'page_name': 'receptionist-dashboard', 'doctors':doctors}
    return render(request, "Reception/receptionist-dashboard.html",context)

def schedule(request):
    appointments = Appointment.objects.all()
    doctors = Doctor.objects.all()
    appointment_list = json.loads(json.dumps(list(appointments.values()), cls=DjangoJSONEncoder))
    for ap in appointment_list:
        if ap["patient_id"]:
            p = Patient.objects.filter(id=ap["patient_id"]).first()
            if p:
                ap['name'] = p.full_name
    context = {'user': request.user, 'page_name': 'appointment-schedule', 'doctors':json.dumps(list(doctors.values())), 'appointments': json.dumps(appointment_list)}
    return render(request, "Reception/appointment-schedule.html",context)

def appointment_form(request):
    doctor = Doctor.objects.all()
    context = {'user': request.user, 'page_name': 'appointment-form', "doctors":doctor}
    return render(request, "Reception/appointment-form.html",context)

def all_appointments(request):
    appointments = Appointment.objects.all()
    context = {'user': request.user, 'page_name': 'all-appointments', 'appointments': appointments}
    return render(request, "Reception/all-appointments.html",context)
