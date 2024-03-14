from django.db import models


# Create your models here.

class Patient(models.Model):
    # user = models.ForeignKey('Account.User', on_delete=models.CASCADE, null=True, blank=True)
    full_name = models.CharField(max_length=100,null=True, blank=True)
    dob = models.DateField(null=True, blank=True)
    gender = models.CharField(max_length=100, choices=(
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other'),
    ),null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    country = models.CharField(max_length=100,null=True, blank=True)
    state = models.CharField(max_length=100,null=True, blank=True)
    city = models.CharField(max_length=100, null=True, blank=True)
    address = models.TextField(max_length=1000, null=True, blank=True)
    zipcode = models.CharField(max_length=100, null=True, blank=True)
    priority = models.IntegerField(null=True, blank=True)

    def __str__(self):
        return self.full_name


class MedicalRecord(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)

    # Medical Conditions
    chronic_illness = models.TextField(max_length=1000, help_text='diabetes, hypertension, etc.', null=True, blank=True)
    acute_illness = models.TextField(max_length=1000, help_text='fever, cold, etc.', null=True, blank=True)
    allergies = models.TextField(max_length=1000, help_text='drug allergies, food allergies, dust allergies, etc.', null=True, blank=True)
    family_history = models.TextField(max_length=1000, help_text='Family history of medical conditions', null=True, blank=True)

    # Medications
    current_medication = models.TextField(max_length=1000, help_text='Current medications (including dosage and frequency)', null=True, blank=True)
    past_medication = models.TextField(max_length=1000, help_text='Previous medications and treatment regimens', null=True, blank=True)
    prescription = models.TextField(max_length=1000, help_text='Prescription History', null=True, blank=True)

