from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt

from Doctor.models import *
# Create your views here.


class AccessView:
    @staticmethod
    @csrf_exempt
    def verify_card(request):
        data = dict(request.POST)
        access = Access.objects.filter(card_uid=data['card_number'])
        if access.exists() and access.count() == 1:
            user = access.first().user
            doctor = Doctor.objects.get(user=user)
            if doctor.checked_in:
                doctor.checked_in = False
                doctor.save()
                return JsonResponse({'status': 'checked_out'})
            else:
                doctor.checked_in = True
                doctor.save()
                return JsonResponse({'status': 'checked_in'})
        else:
            if not access.exists():
                return JsonResponse({'status': 'not_registered'})

            if access.count() > 1:
                return JsonResponse({'status': 'multiple_registered'})

            return JsonResponse({'status': 'error'})



    @staticmethod
    def verify_pin(request):
        pass

    @staticmethod
    def set_card(request):
        pass

