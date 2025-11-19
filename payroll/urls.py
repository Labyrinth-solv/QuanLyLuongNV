from django.urls import path
from . import views

app_name='payroll'

urlpatterns = [
    path('viewStaffSalary/', views.viewStaffSalary, name='viewStaffSalary')
]