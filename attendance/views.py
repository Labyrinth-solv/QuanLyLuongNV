
from django.shortcuts import render, redirect
import pymysql.cursors
from django.conf import settings
import datetime
from datetime import datetime
from datetime import date

from pymysql.cursors import DictCursor

# --- KẾT NỐI DATABASE ---
conn_settings = settings.DATABASES['default']
conn = pymysql.connect(
    host=conn_settings['HOST'],
    user=conn_settings['USER'],
    password=conn_settings['PASSWORD'],
    database=conn_settings['NAME'],
    port=int(conn_settings.get('PORT', 3306)),
    charset='utf8mb4',
    cursorclass=pymysql.cursors.DictCursor,
    autocommit=True
)



def admin_leave(request):
    admin_id = request.session.get('user_id')
    with conn.cursor() as cursor:
        # --- XỬ LÝ POST DUYỆT / TỪ CHỐI ---
        if request.method == 'POST':
            select_day= request.POST.get('select_day')
            detail_id = request.POST.get('detail_id')
            action = request.POST.get('status')  # approve / reject
            action_date=request.POST.get('action_date')
            staff_id=request.POST.get('staff_id')

            status_map = {
                "approve": "Approved",
                "reject": "Rejected"
            }
            status = status_map.get(action, "Pending")


            cursor.execute("""
                UPDATE leavedetail
                SET status=%s
                WHERE detail_id=%s
            """, (status, detail_id))
            conn.commit()
            # 'Nov. 25, 2025' → datetime
            action_date_obj = datetime.strptime(action_date, "%b. %d, %Y")
            # Chỉ lấy phần date
            action_date_str = action_date_obj.strftime("%Y-%m-%d")
            if status=='Approved':
                cursor.execute('''
                    update staffmanagement
                    set action='chamcong'
                    where DATE(timestamp)=%s and staff_id=%s
                ''', (action_date_str, staff_id))
                conn.commit()


            return redirect('attendance:admin_leave')


        # --- LẤY DANH SÁCH NGHỈ PHÉP ---
        cursor.execute("""
            SELECT ld.detail_id, ld.reason, ld.status,
                   p.username AS staff_name, ld.staff_id,
                   ld.leavedetail_date as leave_date
            FROM leavedetail ld
            JOIN person p ON ld.staff_id = p.id
            ORDER BY ld.leavedetail_date DESC
        """)
        details = cursor.fetchall()


        # --- LẤY NHÂN VIÊN ---
        select_day=request.GET.get('select_day')
        with conn.cursor(DictCursor) as cursor:
            cursor.execute('''
                select s2.id, s2.username, s3.action
                from staffprofile s1
                join person s2 on s1.staff_id=s2.id
                left join staffmanagement s3
                on s3.staff_id=s1.staff_id
                    and date_format(s3.timestamp, '%%Y-%%m-%%d')=%s 
            ''', (select_day,))
            staffs=cursor.fetchall()
    today = date.today().isoformat()

    return render(request, "attendance/admin_leave.html", {
        "details": details,
        'staffs':staffs,
        'select_day':select_day,
        'today': today
    })

def chamcong(request):
    admin_id = request.session.get('user_id')
    if request.method == 'POST':
        cursor=conn.cursor()
        select_day = request.POST.get('select_day')
        trangthai = request.POST.get('trangthai')
        staff_id = request.POST.get('staff_id')
        timestamp = datetime.strptime(select_day, '%Y-%m-%d')
        ts_str = timestamp.strftime("%Y-%m-%d")
        # Kiểm tra xem đã có bản ghi cho staff_id trong tháng chưa
        cursor.execute("""
            SELECT manage_id FROM staffmanagement
            WHERE staff_id=%s AND DATE_FORMAT(timestamp, '%%Y-%%m-%%d')=%s
        """, (staff_id, ts_str))
        exist = cursor.fetchone()

        if exist:
            # Update
            cursor.execute("""
                UPDATE staffmanagement
                SET action=%s, timestamp=%s
                WHERE manage_id=%s
            """, (trangthai, ts_str, exist['manage_id']))
        else:
            # Insert
            cursor.execute("""
                INSERT INTO staffmanagement ( admin_id, staff_id, action, timestamp)
                VALUES (%s, %s, %s, %s)
            """, (admin_id, staff_id, trangthai, ts_str))
        conn.commit()
        cursor.close()
        return redirect('attendance:admin_leave')


def staff_attendance(request):
    staff_id = request.session.get('user_id')
    if not staff_id:
        return redirect('users:login')

    today = datetime.date.today()
    checked_in = False

    with conn.cursor() as cursor:
        # --- Xử lý check-in ---
        if request.method == "POST":
            cursor.execute("""
                SELECT * FROM attendance
                WHERE staff_id=%s AND date=%s
            """, (staff_id, today))
            exist = cursor.fetchone()
            if not exist:
                cursor.execute("""
                    INSERT INTO attendance(staff_id, date, status, checkin_time)
                    VALUES (%s, %s, 'present', NOW())
                """, (staff_id, today))
                conn.commit()
                checked_in = True

        # --- Lấy toàn bộ lịch attendance, kết hợp nghỉ phép từ leave/leavedetail ---
        cursor.execute("""
            SELECT a.date, 
                   CASE 
                       WHEN ld.status='Approved' THEN 'leave'
                       WHEN a.status='present' THEN 'present'
                       ELSE 'absent'
                   END AS status
            FROM attendance a
            LEFT JOIN leavedetail ld 
                   ON ld.staff_id = a.staff_id
            LEFT JOIN `leave` l 
                   ON l.leave_id = ld.leave_id AND l.leave_date = a.date
            WHERE a.staff_id=%s
            ORDER BY a.date DESC
        """, (staff_id,))
        records = cursor.fetchall()

    return render(request, "attendance/staff_attendance.html", {
        "records": records,
        "today": today,
        "checked_in": checked_in
    })


def attendance_redirect(request):
    role = request.session.get("user_role")


    if role == "admin":
        return redirect('attendance:admin_leave')
    else:
        return redirect('attendance:staff_calendar')


