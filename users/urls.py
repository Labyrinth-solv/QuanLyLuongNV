from django.urls import path
from . import views

app_name='users'

urlpatterns = [
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('admin_dashboard/', views.admin_dashboard_view, name='admin_dashboard'),
    path('admin/add_staff', views.add_staff_view, name='add_staff'),
    path('admin/list_staff', views.list_staff_view, name='list_staff'),
    path('admin/delete_staff/<str:staff_id>', views.delete_staff_view, name='delete_staff'),
    path('profile/', views.profile_view, name='profile'),
    path('staff_dashboard', views.staff_dashboard, name='staff_dashboard')
]
