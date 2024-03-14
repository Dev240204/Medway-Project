from Account.views import *
from django.urls import path


urlpatterns =  [
    path('login/', login_view, name='login'),
    path('receptionist-dashboard/', receptionist_dashboard, name='receptionist-dashboard'),
    path('register/', register_user, name='register'),
    path('logout/', logout_view, name='logout'),
]