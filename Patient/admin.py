from django.contrib import admin
from Patient.models import Patient, MedicalRecord

# Register your models here.


admin.site.register(Patient)
admin.site.register(MedicalRecord)