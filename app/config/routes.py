from system.core.router import routes

routes['default_controller'] = 'Sessions'

routes['/register'] = 'Sessions#show_register_page'

routes['/login'] = 'Sessions#show_login_page'

routes['POST']['/login'] = 'Sessions#login'

routes['POST']['/register'] = 'Sessions#register'

routes["/logout"] = "Sessions#logout"

routes['/facebook_success/<email>/<first_name>/<last_name>'] = "Sessions#facebook_login_successed"

routes['POST']['/facebook_register'] = 'Sessions#facebook_register'

routes['/courses'] = 'Sessions#courses'

routes['POST']['/add_courses'] = 'Sessions#add_courses'

routes['/courses_page/<course_name>'] = 'Sessions#get_st_courses'

routes['/studentwall'] = 'Sessions#studentwall'

