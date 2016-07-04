"""
    System Core Router File

    Defines the verbs and the routes dictionary for use in the routes config file
"""
routes = {}
routes['GET'] = {}
routes['POST'] = {}
routes['PUT'] = {}
routes['PATCH'] = {}
routes['DELETE'] = {}
routes['POST']['/message'] ="Sessions#add_post"
routes['POST']['/delete/<post_id>'] ="Sessions#delete_post"
routes['POST']['/comment/<post_id>'] ="Sessions#add_comment"