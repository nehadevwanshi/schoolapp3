from system.core.model import Model
import re
from flask import Flask,flash
class Student(Model):
        def __init__(self):
            super(Student, self).__init__()

        def fb_create_user(self, info):
            flag = True;
            sql = "select * from students where email = :email"
            data = {
                "email": info["email"]
            }
            result = self.db.query_db(sql, data)

            if len(result) > 0:
                flag = False
                return {"status": False}

            if not flag:
                return {"status": False, "flag": flag}
            else:
                query = "INSERT into students (first_name, last_name, email, phone_number,password, school_location, created_at, updated_at) VALUES(:first_name, :last_name, :email, :phone_number,:password, :school_location, now(), now())"
                data = {
                    'first_name': info['first_name'],
                    'last_name': info['last_name'],
                    'email': info['email'],
                    'phone_number': info['phone_number'],
                    'school_location': info['school_location'],
                    'password': 'FB User'
                }
                user_id = self.db.query_db(query, data)
                return {"status": True, "user_id": user_id}

        def create_user(self, info):
            flag = True;
            # pattern for email
            email_pat = re.compile(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")

            # pattern for password
            pwd_pat = re.compile(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z].{8,}$)")

            def is_password_valid(pwd):

                if not (re.match(pwd_pat, pwd)):
                    return False
                else:
                    return True

            def is_email_valid(email):

                if not (re.match(email_pat, email)):
                    return False
                else:
                    return True

            if not info['first_name']:
                flash('First Name cannot be blank.', 'fname')
                flag = False
            if len(info['first_name']) < 2:
                flash('First Name must be at least two characters long', 'fshort')
                flag = False

            if not info['first_name'].isalpha():
                flash('First Name can only be letters', 'falpha')
                flag = False

            if not info['last_name']:
                flash('Last Name cannt be blank.', 'lname')
                flag = False

            if len(info['last_name']) < 2:
                flash('Last Name must be at least two characters long', 'lshort')
                flag = False

            if not info['first_name'].isalpha():
                flash('Last Name can only be letters', 'lalpha')
                flag = False

            if not info['email']:
                flash('Email cannot be blank.', 'email')
                flag = False

            if not is_email_valid(info['email']):
                flash('Email format is not valid.', 'email-format')
                flag = False

            if not info['phone_number']:
                flash('Phone number cannot be blank.', 'phone')
                flag = False

            if len(info['phone_number']) < 10:
                flash('Phone number must be 9 digits long and include area code','invalid-phone')
                flag = False

            if not['school_location']:
                flash('Your college location cannot be blank', 'loc')
                flag = False

            if not info['pwd']:
                flash('Password cannot be blank', 'pwd1')
                flag = False

            if not is_password_valid(info['pwd']):
                flash('Password must be eight chars long , at least one upper case , one lowercase and numbers','pwd1-error')
                flag = False

            if info['pwd'] != info['cpwd']:
                flash('Password and confirm password must match.', 'pwd2')
                flag = False

            sql = "select * from students where email = :email"
            data = {
                "email": info["email"]
            }
            result = self.db.query_db(sql, data)
            if len(result) > 0:
                flash("This email has already been used!", 'email-in-use')
                flag = False

            if not flag:
                return {"status": False, "flag": flag}
            else:
                pwd = info['pwd']
                pw_hash = self.bcrypt.generate_password_hash(pwd)
                query = "INSERT into students (first_name, last_name, email, phone_number, school_location, password, created_at, updated_at) VALUES(:first_name, :last_name, :email, :phone_number, :school_location, :pwd, now(), now())"
                data = {
                    'first_name': info['first_name'],
                    'last_name': info['last_name'],
                    'email': info['email'],
                    'phone_number': info['phone_number'],
                    'school_location': info['school_location'],
                    'pwd': pw_hash
                }
                user_id = self.db.query_db(query, data)
                return {"status": True, "user_id": user_id}

        def login_user(self, info):
            flag = True
            sql = "select * from students where email = :email"
            data = {
                "email": info["email"]
            }
            result = self.db.query_db(sql, data)

            if result == None or len(result) == 0:
                flash("Invalid email!", 'no_email')
                flag = False
                return {"status": False, "flag": flag}

            if self.bcrypt.check_password_hash(result[0]["password"], info["pwd"]):
                return {"status": True, "user": result[0]}
            else:
                flash('Invalid password!', 'no_pwd')
                flag = False
                return {"status": False, "flag": flag}

        def get_user_info(self, user_id):
            sql = "select * from students where id = :id"
            data = {
                "id": user_id
            }
            return self.db.get_one(sql, data)

        def get_usre_info_by_email(self, email):
            sql = "select * from students where email = :email"
            data = {
                "email": email
            }
            return self.db.get_one(sql, data)

        def get_courses(self, student_id):
            sql = "select c.id,course_number, c.description from courses c where not exists (select cs.course_id from courses_has_students cs where cs.course_id = c.id and cs.student_id = :student_id)"
            data = {
                "student_id": student_id
            }
            return self.db.query_db(sql, data)

        def add_courses(self, course_id, student_id):
            sql = "insert into courses_has_students (student_id,course_id) values (:student_id,:course_id)"
            data = {
                "student_id": student_id,
                "course_id": course_id
            }
            return self.db.query_db(sql, data)


            # query = "select b.name as course_name, a.lat, a.lng from buildings a " \
            #         "join courses b on a.id=b.building_id " \
            #         "join courses_has_students c on b.id=c.course_id " \
            #         "where c.student_id = :id"
            # data = {
            #     "id": id
            # }



            # select courses.name as course_name, buildings.Lat, buildings.Lng from buildings
            # join courses on buildings.id=courses.building_id
            # join courses_has_students on courses.id=courses_has_students.course_id

        def message(self,student_id,message):
            sql = "insert into posts (student_id,content,created_at,updated_at) values (:student_id,:message,NOW(),NOW())"
            data = {
                "student_id": student_id,
                "message": message
            }
            return self.db.query_db(sql, data)

        def delete_message(self,post_id):
            sql = "delete from messages  where post_id = :post_id"
            data = {
                "post_id": post_id
            }
            self.db.query_db(sql, data) 
            sql = "delete from posts  where id = :post_id"
            return self.db.query_db(sql, data)    

        def get_students(self):
            sql = "select * from students"
            return self.db.query_db(sql)
            
        def getmessages(self):
            sql = "select distinct p.* from posts p left join messages m  on p.id = m.post_id  order by m.created_at desc,p.created_at desc"
            return self.db.query_db(sql)

        def getComments(self,student_id,post_id):
            data = {
                "student_id": student_id,
                "post_id" : post_id
            }
            sql = "select * from messages where student_id = :student_id and post_id = :post_id order by created_at desc"
            return self.db.query_db(sql, data)

        def add_comment(self,student_id,post_id,comment):
            sql = "insert into messages (student_id,post_id,content,created_at,updated_at) values (:student_id,:post_id,:comment,NOW(),NOW())"
            data = {
                "student_id": student_id,
                "comment": comment,
                "post_id" : post_id
            }
            return self.db.query_db(sql, data)

