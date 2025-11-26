from django.urls import path
from . import views

app_name = 'report'

urlpatterns = [
    path('', views.admin_reports, name='admin_reports'),
    path('salary_by_position/', views.salary_by_position, name='salary_by_position'),
    path('salary_payment_status/', views.salary_payment_status, name='salary_payment_status'),
    path('staff_observe/', views.staff_observe, name='staff_observe')
]