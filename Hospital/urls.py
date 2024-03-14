from Hospital.views import *
from django.urls import path

urlpatterns = [
    path('dashboard/', dashboard, name='dashboard'),
    path('schedule/', schedule, name='schedule'),
    path('form/', appointment_form, name='form'),
    path('all-appointments/', all_appointments, name='all-appointments'),
]