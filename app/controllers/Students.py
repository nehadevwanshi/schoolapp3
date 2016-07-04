from system.core.controller import *
class Students(Controller):
    def __init__(self, action):
        super(Students, self).__init__(action)

        self.load_model('Student')

        self.db = self._app.db

    def index(self):
        return self.load_view('index.html')

