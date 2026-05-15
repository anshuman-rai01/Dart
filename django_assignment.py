"""
===========================================================
Django Assignment - Moodle Template
Course: Web Frameworks — Django

Syllabus Coverage:
- MVC architecture understanding
- Project setup and configuration
- Connecting to databases
- Creating models and running migrations
- Querying the database
- Django views and templates
- URL routing
- Template rendering and context passing
- Form handling and submitted data display

Instructions:
- DO NOT change function names
- DO NOT modify driver function
- Implement logic only inside the marked sections
- Each function carries 1 mark
===========================================================
"""

"""
-----------------------------------------------------------
DUMMY DATA (You may use these for testing)
-----------------------------------------------------------
"""

sample_student_record = {
    "id": 1,
    "name": "Aarav",
    "course": "Django"
}

sample_form_submission = {
    "username": "Aarav",
    "email": "aarav@gmail.com"
}

sample_query_results = [
    {"id": 1, "name": "Aarav"},
    {"id": 2, "name": "Riya"}
]

sample_context = {
    "title": "Dashboard",
    "user": "Aarav"
}

"""
-----------------------------------------------------------
FUNCTION 1
-----------------------------------------------------------
Purpose:
Simulate Django project configuration setup

Parameters:
- project_name (str)

Constraints:
- Return formatted configuration message

Base Test Cases:
setup_project("college_portal")
→ "Project college_portal configured"
"""

def setup_project(project_name):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 2
-----------------------------------------------------------
Purpose:
Create model data dictionary

Parameters:
- id (int)
- name (str)
- course (str)

Constraints:
- Return dictionary representing model object

Base Test Cases:
create_model_record(1,"Aarav","Django")
→ {"id":1,"name":"Aarav","course":"Django"}
"""

def create_model_record(id, name, course):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 3
-----------------------------------------------------------
Purpose:
Simulate migration status checker

Parameters:
- migration_name (str)

Constraints:
- Return migration applied message

Base Test Cases:
run_migration("initial_migration")
→ "Migration applied"
"""

def run_migration(migration_name):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 4
-----------------------------------------------------------
Purpose:
Fetch all records from query result list

Parameters:
- records (list)

Constraints:
- Return complete list

Base Test Cases:
fetch_all_records(sample_query_results)
→ sample_query_results
"""

def fetch_all_records(records):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 5
-----------------------------------------------------------
Purpose:
Filter records by ID

Parameters:
- records (list)
- record_id (int)

Constraints:
- Return matching record

Base Test Cases:
filter_record_by_id(sample_query_results,1)
→ {"id":1,"name":"Aarav"}
"""

def filter_record_by_id(records, record_id):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 6
-----------------------------------------------------------
Purpose:
Simulate Django view response

Parameters:
- request_type (str)

Constraints:
- Return formatted response string

Base Test Cases:
django_view("GET")
→ "Handling GET request"
"""

def django_view(request_type):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 7
-----------------------------------------------------------
Purpose:
Generate URL path for route

Parameters:
- route_name (str)

Constraints:
- Return URL path string

Base Test Cases:
generate_route("dashboard")
→ "/dashboard/"
"""

def generate_route(route_name):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 8
-----------------------------------------------------------
Purpose:
Build template rendering context

Parameters:
- context_data (dict)

Constraints:
- Return dictionary

Base Test Cases:
build_context(sample_context)
→ sample_context
"""

def build_context(context_data):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 9
-----------------------------------------------------------
Purpose:
Validate submitted form data

Parameters:
- form_data (dict)

Constraints:
- Email must contain "@"
- Return True or False

Base Test Cases:
validate_form(sample_form_submission)
→ True
"""

def validate_form(form_data):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 10
-----------------------------------------------------------
Purpose:
Display submitted form data

Parameters:
- form_data (dict)

Constraints:
- Return formatted string

Base Test Cases:
display_form_data(sample_form_submission)
→ "User: Aarav"
"""

def display_form_data(form_data):
    # STUDENT CODE STARTS HERE


    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 11 (DRIVER FUNCTION)
-----------------------------------------------------------
Purpose:
Test all student functions
DO NOT MODIFY THIS FUNCTION
-----------------------------------------------------------
"""

def driver():
    print("---- DJANGO ASSIGNMENT DRIVER START ----")

    print("Project Setup:",
          setup_project("college_portal"))

    print("Create Model:",
          create_model_record(1, "Aarav", "Django"))

    print("Migration:",
          run_migration("initial_migration"))

    print("All Records:",
          fetch_all_records(sample_query_results))

    print("Filtered Record:",
          filter_record_by_id(sample_query_results, 1))

    print("View Response:",
          django_view("GET"))

    print("Generated Route:",
          generate_route("dashboard"))

    print("Context:",
          build_context(sample_context))

    print("Form Validation:",
          validate_form(sample_form_submission))

    print("Submitted Data:",
          display_form_data(sample_form_submission))

    print("---- DJANGO ASSIGNMENT DRIVER END ----")


"""
-----------------------------------------------------------
RUN DRIVER
-----------------------------------------------------------
"""

driver()