from django.contrib import admin
from Doctor.models import Doctor, OperatingDay, OperatingHour, PersonalAssistant, Tag


# Register your models here.


class DoctorAdmin(admin.ModelAdmin):
    filter_horizontal = ('tags',)


admin.site.register(Tag)
admin.site.register(Doctor, DoctorAdmin)
admin.site.register(OperatingDay)
admin.site.register(OperatingHour)
admin.site.register(PersonalAssistant)
