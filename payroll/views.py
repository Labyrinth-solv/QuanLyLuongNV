from django.shortcuts import render
import pymysql.cursors
from django.db import connection
from pymysql.cursors import DictCursor
from django.conf import settings


conn_settings = settings.DATABASES['default']
conn = pymysql.connect(
    host=conn_settings['HOST'],
    user=conn_settings['USER'],
    password=conn_settings['PASSWORD'],
    database=conn_settings['NAME'],
    port=int(conn_settings.get('PORT', 3306)),
    charset='utf8mb4',
    cursorclass=DictCursor
)
# Create your views here.
def viewStaffSalary(request):
    cursor=conn.cursor(DictCursor)
    sql='''
        SELECT s1.username, s2.rank, s2.amount, s2.multiplier
        from staffprofile s
        join person s1 on s1.id=s.staff_id
        join salary s2 on s2.salary_id=s.salary_id
    '''
    cursor.execute(sql)
    view_salary=cursor.fetchall()
    cursor.close()

    return render(request, 'view_staff_salary.html', {'view_salary':view_salary})
