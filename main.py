import psycopg2
from psycopg2 import sql
import datetime
import random

# Database connection details
DB_NAME = "scheduler_db"
DB_USER = "arturtorosyan"  # <-- change if needed
DB_PASSWORD = ""
DB_HOST = "localhost"
DB_PORT = "5432"

def connect_db():
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
        print("✅ Database connection established.")
        return conn
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        return None

def close_db(conn):
    if conn:
        conn.close()
        print("🔒 Database connection closed.")

# Insert functions
def insert_course(conn, name, description):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO courses (name, description)
                VALUES (%s, %s)
                RETURNING id;
            """, (name, description))
            course_id = cur.fetchone()[0]
            conn.commit()
            print(f"📚 Course '{name}' inserted with ID {course_id}.")
            return course_id
    except Exception as e:
        conn.rollback()
        print(f"❌ Insert course failed: {e}")

def insert_classroom(conn, name):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO classrooms (name)
                VALUES (%s)
                RETURNING id;
            """, (name,))
            classroom_id = cur.fetchone()[0]
            conn.commit()
            print(f"🏫 Classroom '{name}' inserted with ID {classroom_id}.")
            return classroom_id
    except Exception as e:
        conn.rollback()
        print(f"❌ Insert classroom failed: {e}")

def insert_period(conn, name, start_time, end_time):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO periods (name, start_time, end_time)
                VALUES (%s, %s, %s)
                RETURNING id;
            """, (name, start_time, end_time))
            period_id = cur.fetchone()[0]
            conn.commit()
            print(f"🕒 Period '{name}' inserted with ID {period_id}.")
            return period_id
    except Exception as e:
        conn.rollback()
        print(f"❌ Insert period failed: {e}")

def allocate_classroom(conn, course_id, classroom_id, period_id):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                INSERT INTO allocations (course_id, classroom_id, period_id)
                VALUES (%s, %s, %s);
            """, (course_id, classroom_id, period_id))
            conn.commit()
            print(f"✅ Allocation: Course {course_id} to Classroom {classroom_id} during Period {period_id}.")
    except psycopg2.errors.UniqueViolation:
        conn.rollback()
        print(f"⚠️ Allocation failed: Course {course_id} already assigned to Period {period_id}!")
    except Exception as e:
        conn.rollback()
        print(f"❌ Allocation failed: {e}")

# Update functions
def update_course(conn, course_id, new_name, new_description):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                UPDATE courses
                SET name = %s, description = %s
                WHERE id = %s;
            """, (new_name, new_description, course_id))
            conn.commit()
            print(f"✏️ Updated course ID {course_id}.")
    except Exception as e:
        conn.rollback()
        print(f"❌ Update course failed: {e}")

def update_classroom(conn, classroom_id, new_name):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                UPDATE classrooms
                SET name = %s
                WHERE id = %s;
            """, (new_name, classroom_id))
            conn.commit()
            print(f"✏️ Updated classroom ID {classroom_id}.")
    except Exception as e:
        conn.rollback()
        print(f"❌ Update classroom failed: {e}")

# Delete functions
def delete_course(conn, course_id):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                DELETE FROM courses
                WHERE id = %s;
            """, (course_id,))
            conn.commit()
            print(f"🗑️ Deleted course ID {course_id}.")
    except Exception as e:
        conn.rollback()
        print(f"❌ Delete course failed: {e}")

def delete_classroom(conn, classroom_id):
    try:
        with conn.cursor() as cur:
            cur.execute("""
                DELETE FROM classrooms
                WHERE id = %s;
            """, (classroom_id,))
            conn.commit()
            print(f"🗑️ Deleted classroom ID {classroom_id}.")
    except Exception as e:
        conn.rollback()
        print(f"❌ Delete classroom failed: {e}")

# Viewing Functions
def list_courses(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT id, name, description FROM courses;")
        rows = cur.fetchall()
        print("\n📚 Courses:")
        for row in rows:
            print(f"ID {row[0]}: {row[1]} - {row[2]}")

def list_classrooms(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT id, name FROM classrooms;")
        rows = cur.fetchall()
        print("\n🏫 Classrooms:")
        for row in rows:
            print(f"ID {row[0]}: {row[1]}")

def list_periods(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT id, name, start_time, end_time FROM periods;")
        rows = cur.fetchall()
        print("\n🕒 Periods:")
        for row in rows:
            print(f"ID {row[0]}: {row[1]} ({row[2]} - {row[3]})")

def list_allocations(conn):
    with conn.cursor() as cur:
        cur.execute("""
            SELECT c.name, r.name, p.name, p.start_time, p.end_time
            FROM allocations a
            JOIN courses c ON a.course_id = c.id
            JOIN classrooms r ON a.classroom_id = r.id
            JOIN periods p ON a.period_id = p.id
            ORDER BY p.start_time;
        """)
        rows = cur.fetchall()
        print("\n📅 Allocations:")
        for row in rows:
            print(f"{row[0]} → {row[1]} during {row[2]} ({row[3]} - {row[4]})")

# Helper random functions
def random_course():
    names = ["Math", "Physics", "Chemistry", "History", "Biology", "Art", "Music", "PE"]
    name = random.choice(names) + f" {random.randint(100, 499)}"
    desc = f"Description for {name}"
    return name, desc

def random_classroom():
    rooms = ["A", "B", "C", "D", "E", "F"]
    return f"Room {random.choice(rooms)}"

def random_period(i):
    hour = 8 + i
    start = datetime.time(hour, 0)
    end = datetime.time(hour + 1, 0)
    return f"Period {i}", start, end

# Reset database
def reset_database(conn):
    try:
        with conn.cursor() as cur:
            cur.execute("DELETE FROM allocations;")
            cur.execute("DELETE FROM courses;")
            cur.execute("DELETE FROM classrooms;")
            cur.execute("DELETE FROM periods;")
            conn.commit()
            print("🧹 Database reset.")
    except Exception as e:
        conn.rollback()
        print(f"❌ Reset failed: {e}")

# Populate database with sample data
def populate_database(conn):
    courses = []
    classrooms = []
    periods = []

    for _ in range(5):
        name, desc = random_course()
        courses.append(insert_course(conn, name, desc))

    for _ in range(3):
        name = random_classroom()
        classrooms.append(insert_classroom(conn, name))

    for i in range(5):
        name, start, end = random_period(i)
        periods.append(insert_period(conn, name, start, end))

    for course in courses:
        classroom = random.choice(classrooms)
        period = random.choice(periods)
        allocate_classroom(conn, course, classroom, period)

def main():
    conn = connect_db()
    if not conn:
        return

    try:
        reset_database(conn)
        populate_database(conn)
        list_courses(conn)
        list_classrooms(conn)
        list_periods(conn)
        list_allocations(conn)
    finally:
        close_db(conn)

if __name__ == "__main__":
    main()

