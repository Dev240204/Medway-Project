from django.db import models
from Patient.models import *


# Create your models here.

class Appointment(models.Model):
    doctor = models.ForeignKey('Doctor.Doctor', on_delete=models.CASCADE,null=True, blank=True)
    # patient = models.ForeignKey('Account.User', on_delete=models.CASCADE, null=True, blank=True)
    patient = models.ForeignKey('Patient.Patient', on_delete=models.CASCADE, null=True, blank=True)
    date = models.DateField(auto_now_add=True)
    time = models.TimeField(auto_now_add=True)
    estimated_time_required = models.IntegerField(help_text='in minutes', null=True, blank=True)
    message = models.TextField(max_length=1000,null=True, blank=True)

    def __str__(self):
        if self.patient:
            return self.patient.full_name
        else:
            return f'Appointment Object {self.id}'


class Waiting(models.Model):
    patient = models.ForeignKey('Account.User', on_delete=models.CASCADE)
    date = models.DateField()
    time_in = models.TimeField()
    estimated_time_required = models.IntegerField(help_text='in minutes')
    priority = models.IntegerField(help_text='1 is highest priority, 5 is lowest priority', null=True, blank=True)

    def __str__(self):
        return Patient.objects.get(user=self.patient).full_name
