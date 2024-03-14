from django.db import models

# Create your models here.
WEEK_DAYS = (
    ('monday', 'Monday'),
    ('tuesday', 'Tuesday'),
    ('wednesday', 'Wednesday'),
    ('thursday', 'Thursday'),
    ('friday', 'Friday'),
    ('saturday', 'Saturday'),
    ('sunday', 'Sunday'),
)


class Tag(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Doctor(models.Model):
    user = models.ForeignKey('Account.User', on_delete=models.CASCADE, null=True)
    card_id = models.CharField(max_length=100, null=True, blank=True)
    hospital = models.ForeignKey('Hospital.Hospital', on_delete=models.CASCADE, null=True)
    name = models.CharField(max_length=100)
    specialization = models.CharField(max_length=100)
    qualification = models.CharField(max_length=100)
    experience = models.CharField(max_length=100)
    fees = models.CharField(max_length=100)
    tags = models.ManyToManyField(Tag, blank=True)
    checked_in = models.BooleanField(default=False)
    image = models.ImageField(upload_to='media/doctor/images')

    def __str__(self):
        return self.name


class OperatingDay(models.Model):
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    day = models.CharField(max_length=100, choices=WEEK_DAYS, unique=True)

    def __str__(self):
        return self.day


class OperatingHour(models.Model):
    day = models.ForeignKey(OperatingDay, on_delete=models.CASCADE)
    start_time = models.CharField(max_length=100)
    end_time = models.CharField(max_length=100)

    def __str__(self):
        return self.start_time + ' - ' + self.end_time + ' (' + self.day.day + ')'


class PersonalAssistant(models.Model):
    user = models.ForeignKey('Account.User', on_delete=models.CASCADE, null=True)
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    description = models.TextField(max_length=250)

    active = models.BooleanField(default=True)

    def __str__(self):
        return self.name


class Access(models.Model):
    user = models.ForeignKey('Account.User', on_delete=models.CASCADE, null=True, unique=True)
    card_uid = models.CharField(max_length=500, null=True, blank=True, unique=True)
    pin = models.CharField(max_length=6, unique=True)