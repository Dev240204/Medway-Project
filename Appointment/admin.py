from django.contrib import admin
from Appointment.models import Appointment, Waiting
# Register your models here.


admin.site.register(Appointment)
admin.site.register(Waiting)
