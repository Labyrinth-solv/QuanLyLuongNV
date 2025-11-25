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
    month = request.GET.get('month')
    year = request.GET.get('year')

    general_details = {}
    rank_details = []
    cursor = conn.cursor()

    if month and year:
        cursor.execute("""
            SELECT 
                SUM(total_amount)*1000 AS total_payment,
                AVG(total_amount)*1000 AS AVG_payment,
                MIN(total_amount)*1000 AS MIN_payment,
                MAX(total_amount)*1000 AS MAX_payment
            FROM salarypayment
            WHERE MONTH(payment_date) = %s
                AND YEAR(payment_date) = %s
        """, [month, year])
        row = cursor.fetchone()
        total_payment = float(row["total_payment"]) if row["total_payment"] is not None else 0
        AVG_payment = float(row["AVG_payment"]) if row["AVG_payment"] is not None else 0
        MIN_payment = float(row["MIN_payment"]) if row["MIN_payment"] is not None else 0
        MAX_payment = float(row["MAX_payment"]) if row["MAX_payment"] is not None else 0
        general_details = {
            "total_payment": total_payment,
            "AVG_payment": AVG_payment,
            "MIN_payment": MIN_payment,
            "MAX_payment": MAX_payment,
        }

        cursor.execute("""
            SELECT 
                s.rank AS position,
                COUNT(sp.staff_id) AS total_staff,
                SUM(spay.total_amount)*1000 AS total_paid
            FROM salarypayment spay
            JOIN staffprofile sp ON spay.staff_id = sp.staff_id
            JOIN salary s ON sp.salary_id = s.salary_id
            WHERE MONTH(spay.payment_date) = %s
                AND YEAR(spay.payment_date) = %s
            GROUP BY s.rank
            ORDER BY SUM(spay.total_amount) DESC;
        """, [month, year])

        rows = cursor.fetchall()

        rank_details = [
            {
                "position": r["position"],
                "total_staff": r["total_staff"],
                "total_paid": float(r["total_paid"]) if r["total_paid"] is not None else 0
            }
            for r in rows
        ]
        cursor.close()
    return render(request, "report/salary_by_position.html", {
        "month": month,
        "year": year,
        "general_details": general_details,
        "rank_details": rank_details,
        "months": (1,2,3,4,5,6,7,8,9,10,11,12),
    })

def salary_payment_status(request):
    month = request.GET.get("month")
    payment_filter=request.GET.get('payment_filter')
    staff_name=request.GET.get('staff_name')
    cursor=conn.cursor()
    query='''
        select s.staff_id, s1.username, l.rank, MAX(sp.total_amount) as total_amount, 
        (l.amount*l.multiplier) as amount,
        COUNT(CASE 
            WHEN s3.action='vang' AND DATE_FORMAT(s3.timestamp, '%%Y-%%m') = %s
            THEN 1 
         END) AS absent,
        CASE 
            WHEN sp.staff_id IS NOT NULL THEN 1
                ELSE 0
            END AS payment_status
        FROM staffprofile s
        JOIN salary l ON l.salary_id = s.salary_id
        JOIN person s1 ON s.staff_id = s1.id
        LEFT JOIN staffmanagement s3 
               ON s3.staff_id = s.staff_id 
               AND DATE_FORMAT(s3.timestamp, '%%Y-%%m') = %s
        LEFT JOIN salarypayment sp 
               ON sp.staff_id = s.staff_id 
               AND DATE_FORMAT(sp.payment_date, '%%Y-%%m') = %s
        WHERE 1=1
    '''
    params = [month, month, month]

    # Lọc theo trạng thái thanh toán nếu có
    if payment_filter == 'paid':
        query += ' AND sp.staff_id IS NOT NULL'
    elif payment_filter == 'unpaid':
        query += ' AND sp.staff_id IS NULL'

    # Lọc theo tên nhân viên nếu có
    if staff_name:
        query += ' AND s1.username LIKE %s'
        params.append(f'%{staff_name}%')

    query += ' GROUP BY s.staff_id, s1.username, l.rank ORDER BY s.staff_id'
    cursor.execute(query, params)
    staffs=cursor.fetchall()
    return render(request, 'report/salary_payment_status.html', {
        'staffs':staffs,
        'selected_month':month,
        'payment_filter':payment_filter
    })