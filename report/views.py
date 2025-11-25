import pymysql.cursors
from django.shortcuts import render, redirect
from django.conf import settings
from pymysql.cursors import DictCursor

# Kết nối database
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

def admin_reports(request):
    if 'user_id' not in request.session or request.session.get('user_role') != 'Admin':
        return redirect('users:login')
    
    return render(request, 'report/admin_reports.html')

def salary_by_position(request):
    if 'user_id' not in request.session or request.session.get('user_role') != 'Admin':
        return redirect('users:login')
    
    salary_stats = []
    
    try:
        with conn.cursor() as cursor:
            # Thống kê lương theo chức vụ (rank)
            query = """
                SELECT
                    s.rank AS chuc_vu,
                    COUNT(sp.staff_id) AS so_nhan_vien,
                    (s.amount * s.multiplier * COUNT(sp.staff_id) * 1000) AS tong_luong,
                    (s.amount * 1000) AS luong_co_ban,
                    s.multiplier AS he_so
                FROM salary s
                LEFT JOIN staffprofile sp ON s.salary_id = sp.salary_id
                GROUP BY s.salary_id, s.rank, s.amount, s.multiplier
                ORDER BY s.amount DESC;
            """
            cursor.execute(query)
            salary_stats = cursor.fetchall()

            query = """
                SELECT
                    COUNT(sp.staff_id) AS tong_nhan_vien,
                    SUM(s.amount * s.multiplier * 1000) AS tong_luong,
                    AVG(s.amount * s.multiplier * 1000) AS trung_binh_luong,
                    MIN(s.amount * s.multiplier * 1000) AS luong_nho_nhat,
                    MAX(s.amount * s.multiplier * 1000) AS luong_lon_nhat
                FROM salary s
                JOIN staffprofile sp ON s.salary_id = sp.salary_id;
            """
            cursor.execute(query)
            overall_stats = cursor.fetchone()
    
    except Exception as e:
        print("Lỗi khi truy vấn dữ liệu:", e)
    
    context = {
        'salary_stats': salary_stats,
        'total_stats': overall_stats
    }
    return render(request, 'report/salary_by_position.html', context)

def salary_payment_status(request):
    pass