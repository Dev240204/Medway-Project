from Patient.views import *
from django.urls import path

urlpatterns = [
    path('dashboard/', dashboard, name='patient-dashboard'),
]