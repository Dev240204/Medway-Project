from django.shortcuts import render,redirect
from django.http import HttpResponse
from Patient.models import *
from Appointment.models import *
from Doctor.models import *

# Create your views here.
def schedule(request):
    return render(request,'Reception/appointment-schedule.html')

def AppointmentForm(request):
    if request.method == 'POST':
        email = request.POST.get('appointment-email')
        firstname = request.POST.get('appointment-firstname')
        middlename = request.POST.get('appointment-middlename')
        lastname = request.POST.get('appointment-lastname')
        name = firstname + " " + middlename + " " + lastname
        dob = request.POST.get('appointment-dob')
        gender = request.POST.get('appointment-gender')
        country = request.POST.get('appointment-country')
        state = request.POST.get('appointment-state')
        city = request.POST.get('appointment-city')
        address = request.POST.get('appointment-address')
        zipcode = request.POST.get('appointment-zipcode')
        priority = request.POST.get('appointment-priority')
        doctor = request.POST.get('appointment-doctor')

        patient = Patient()
        patient.full_name = name
        patient.email = email
        # patient.dob = dob
        patient.gender = gender
        patient.country = country
        patient.state = state
        patient.city = city
        patient.address = address
        patient.zipcode = zipcode
        patient.priority = priority
        patient.save()



        # Appointment Allocation
        doctor = Doctor.objects.get(id=int(doctor))
        appointment = Appointment()
        appointment.doctor = doctor
        appointment.patient = patient
        appointment.estimated_time_required = 30
        appointment.message = ' '
        appointment.save()


        return render(request,'Reception/appointment-form.html')
    else :
        return render(request,'Reception/appointment-form.html')