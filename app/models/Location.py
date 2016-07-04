from system.core.model import Model
import re
from flask import Flask,flash
class Location(Model):
    def __init__(self):
        super(Location, self).__init__()

    def get_location(self):
        print "i am in get locations"
        query = "select * from buildings"
        print query, "This is query"
        return self.db.query_db(query)

    def spec_location(self, id):
        query = "select students.first_name, group_concat(courses.course_number,' '), group_concat(courses.name,' ') as course_name, buildings.building_name, buildings.Lat, buildings.Lng from students " \
                "join courses_has_students on students.id = courses_has_students.student_id " \
                "join courses on courses.id = courses_has_students.course_id " \
                "join buildings on buildings.id = courses.building_id "\
                "where students.id = :id group by buildings.building_name"

        data = {
                "id": id
            }
        loc =  self.db.query_db(query, data)
        print loc, "ZZzzzzzzzzzzzzzzzzzzzzz"
        return loc





