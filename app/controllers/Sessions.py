from system.core.controller import *
from flask import Flask,flash,json

class Sessions(Controller):
    def __init__(self, action):
        super(Sessions, self).__init__(action)
        self.load_model("Student")
        self.load_model('Location')
        self.load_model('Course')


    def index(self):
        if "user_id" in session:
            result = self.models["Student"].get_user_info(session["user_id"])
            print result
            if len(result) > 0:
                return self.load_view("success.html")
        return self.load_view('index.html')

    def show_register_page(self):
        return self.load_view('register.html')

    def show_login_page(self):
        return self.load_view('index.html')

    # def register(self):
    #     user_status = self.models['Student'].create_user(request.form)
    #
    #     if user_status["status"] == False:
    #         return redirect("/register")
    #
    #     session["user_id"] = user_status["user_id"]
    #     locations = self.models['Location'].spec_location(session["user_id"])
    #
    #     print locations, "location are here"
    #     return self.load_view('success.html', locations=json.dumps(locations))

    def register(self):
        user_status = self.models['Student'].create_user(request.form)
        print user_status, "heloooooooooo"

        if user_status["status"] == False:
            return redirect("/register")

        session['name'] = user_status['user'][0]['first_name']
        session['id'] = user_status['user'][0]['id']
        locations = self.models['Location'].spec_location(session["user_id"])
        print locations, "location are here"
        return self.load_view('success.html', locations=json.dumps(locations))

    def login(self):
        info = {
            "email": request.form["email"],
            "pwd": request.form["pwd"]
        }

        result = self.models["Student"].login_user(info)

        print result
        if result is not None and result["status"] == False:
            return redirect("/")
        else:
            session["name"] = result['user']["first_name"]
            session['user_id'] = result['user']['id']
            locations = self.models['Location'].spec_location(session["user_id"])
            print locations, "location are here"
            return self.load_view('success.html', locations=json.dumps(locations))

    def facebook_login_successed(self, first_name, last_name, email):
        result = self.models["Student"].get_usre_info_by_email(email)
        print result
        if result is not None and len(result) > 0:
            session["name"] = result["first_name"]
            session['user_id'] = result['id']
            locations = self.models['Location'].spec_location(session["user_id"])
            print locations, "location are here"
            return self.load_view('success.html', locations=json.dumps(locations), result=result)
        user_info = {
            'fname': first_name,
            'lname': last_name,
            'email': email
        }
        return self.load_view("fb_register.html", user_info=user_info)

    def facebook_register(self):
        user_status = self.models['Student'].fb_create_user(request.form)
        print user_status

        if user_status["status"] == False:
            user_info = {
                'fname': request.form['first_name'],
                'lname': request.form['last_name'],
                'email': request.form['email']
            }
            return self.load_view("fb_register.html", user_info=user_info)

        # session['name'] = user_status['users']['first_name']
        session['user_id'] = user_status['user_id']
        print session['user_id']
        locations = self.models['Location'].spec_location(session["user_id"])
        print locations, "location are here"
        return self.load_view('success.html', locations=json.dumps(locations))

    def logout(self):
        if "user_id" in session:
            session.pop("user_id")

        return redirect("/")

    def courses(self):
        student_id = session['user_id']
        courses = self.models['Student'].get_courses(student_id)
        return self.load_view('addcourses.html', courses=courses)

    def add_courses(self):
        courses = request.form.getlist("courses")
        student_id = session['user_id']
        for course in courses:
            print "course selected : " + course
            self.models['Student'].add_courses(course, student_id)
        flash(" Course added successfully", "add_courses")
        locations = self.models['Location'].spec_location(session["user_id"])
        print locations, "location are here"
        return self.load_view('success.html', locations=json.dumps(locations))

    def get_st_courses(self,course_name):
        return self.load_view('courses.html',course_name=course_name)

    #The begening of the wall .............

    def studentwall(self):
        messages = self.models['Student'].getmessages()
        students  = self.models['Student'].get_students()
        print students
        for message in messages:
            comments = self.models['Student'].getComments(session['user_id'],message['id'])
            message['comments'] = comments
        return self.load_view('studentwall.html',messages =messages,students=students)
      

    def add_post(self):
        messages = self.models['Student'].message(request.form['user_id'],request.form['message'])
        flash("Message posted successfully","message_success")
        return redirect("/studentwall")

    def delete_post(self,post_id):
        messages = self.models['Student'].delete_message(post_id)
        flash("Message deleted successfully","message_success")
        return redirect("/studentwall")
   
    def add_comment(self,post_id):
        messages = self.models['Student'].add_comment(session['user_id'],post_id,request.form['comment'])
        flash("Comment posted successfully","message_success")
        return redirect("/studentwall")

