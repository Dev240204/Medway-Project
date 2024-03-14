from django.urls import path
from Appointment.views import *


urlpatterns = [
    path('form/', AppointmentForm ,name='AppointmentForm'),
    path('schedule/',schedule,name='schedule'),
]