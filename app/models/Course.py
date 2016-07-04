from system.core.model import Model

class Course(Model):
    def __init__(self):
        super(Course, self).__init__()

    def get_courseid(self, info):
        query = "SELECT courses.id from courses WHERE course_number =:course_number"
        data = {
            'course_number': info['course_number']
        }
        course_id = self.db.query_db(query, data)
        immediate = "INSERT into courses_has_students (course_id, student_id) VALUES (:course_id, :student_id)"
        immediate_data = {
            'course_id': course_id['course_id'],
            'student_id': info['student_id']
        }
        return self.db.query_db(immediate, immediate_data)