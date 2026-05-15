"""
===========================================================
Flask Assignment - Moodle Template
Course: Web Frameworks — Flask

Syllabus Coverage:
- Basic routing and URL rules
- Request and response handling
- Jinja2 templating
- Form handling and validation
- Building REST APIs that return JSON

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

sample_form_data = {
    "username": "Aarav",
    "email": "aarav@gmail.com",
    "password": "pass123"
}

sample_request_args = {
    "page": "1",
    "limit": "10",
    "search": "flask"
}

sample_user_data = {
    "id": 101,
    "name": "Aarav",
    "course": "Web Frameworks"
}

sample_api_response = {
    "status": "success",
    "message": "Data fetched successfully"
}

"""
-----------------------------------------------------------
FUNCTION 1
-----------------------------------------------------------
Purpose:
Create a basic Flask route response

Parameters:
- route_name (str)

Constraints:
- Return a formatted string response
- Simulate Flask route output

Base Test Cases:
basic_route("home") → "Route: home"
"""

def basic_route(route_name):
    # STUDENT CODE STARTS HERE
    return f"Route: {route_name}"
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 2
-----------------------------------------------------------
Purpose:
Generate a welcome response message

Parameters:
- username (str)

Constraints:
- Return response string
- Use string formatting

Base Test Cases:
welcome_response("Aarav")
→ "Welcome Aarav"
"""

def welcome_response(username):
    # STUDENT CODE STARTS HERE
    return f"Welcome {username}"
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 3
-----------------------------------------------------------
Purpose:
Build Jinja2 template context dictionary

Parameters:
- user_data (dict)

Constraints:
- Return dictionary
- Must include name and course keys

Base Test Cases:
build_template_context(sample_user_data)
→ {"name":"Aarav","course":"Web Frameworks"}
"""

def build_template_context(user_data):
    # STUDENT CODE STARTS HERE
    return {"name": user_data["name"], "course": user_data["course"]}
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 4
-----------------------------------------------------------
Purpose:
Validate email field from form data

Parameters:
- form_data (dict)

Constraints:
- Email must contain "@"
- Return True or False

Base Test Cases:
validate_email(sample_form_data)
→ True
"""

def validate_email(form_data):
    # STUDENT CODE STARTS HERE
    return "@" in form_data.get("email", "")
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 5
-----------------------------------------------------------
Purpose:
Validate password length

Parameters:
- form_data (dict)

Constraints:
- Password length must be >= 6
- Return True or False

Base Test Cases:
validate_password(sample_form_data)
→ True
"""

def validate_password(form_data):
    # STUDENT CODE STARTS HERE
    return len(form_data.get("password", "")) >= 6
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 6
-----------------------------------------------------------
Purpose:
Create JSON response dictionary

Parameters:
- status (str)
- message (str)

Constraints:
- Return dictionary simulating JSON response

Base Test Cases:
create_json_response("success","Done")
→ {"status":"success","message":"Done"}
"""

def create_json_response(status, message):
    # STUDENT CODE STARTS HERE
    return {"status": status, "message": message}
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 7
-----------------------------------------------------------
Purpose:
Extract query parameters from request args

Parameters:
- request_args (dict)

Constraints:
- Return tuple(page, limit)

Base Test Cases:
parse_query_params(sample_request_args)
→ ("1","10")
"""

def parse_query_params(request_args):
    # STUDENT CODE STARTS HERE
    return (request_args.get("page"), request_args.get("limit"))
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 8
-----------------------------------------------------------
Purpose:
Simulate API GET endpoint logic

Parameters:
- data (dict)

Constraints:
- Return success response dictionary

Base Test Cases:
api_get_user(sample_user_data)
→ {"status":"success","data":sample_user_data}
"""

def api_get_user(data):
    # STUDENT CODE STARTS HERE
    return {"status": "success", "data": data}
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 9
-----------------------------------------------------------
Purpose:
Simulate form submission handling

Parameters:
- form_data (dict)

Constraints:
- Return submission confirmation string

Base Test Cases:
handle_form_submission(sample_form_data)
→ "Form submitted"
"""

def handle_form_submission(form_data):
    # STUDENT CODE STARTS HERE
    return "Form submitted"
    # STUDENT CODE ENDS HERE


"""
-----------------------------------------------------------
FUNCTION 10
-----------------------------------------------------------
Purpose:
Generate route URL string

Parameters:
- endpoint (str)

Constraints:
- Return URL path format

Base Test Cases:
generate_url("dashboard")
→ "/dashboard"
"""

def generate_url(endpoint):
    # STUDENT CODE STARTS HERE
    return f"/{endpoint}"
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
    print("---- FLASK ASSIGNMENT DRIVER START ----")

    print("Basic Route:", basic_route("home"))
    print("Welcome Response:", welcome_response("Aarav"))
    print("Template Context:", build_template_context(sample_user_data))

    print("Email Valid:", validate_email(sample_form_data))
    print("Password Valid:", validate_password(sample_form_data))

    print("JSON Response:",
          create_json_response("success", "Operation Completed"))

    print("Query Params:",
          parse_query_params(sample_request_args))

    print("API GET Response:",
          api_get_user(sample_user_data))

    print("Form Submission:",
          handle_form_submission(sample_form_data))

    print("Generated URL:",
          generate_url("dashboard"))

    print("---- FLASK ASSIGNMENT DRIVER END ----")


"""
-----------------------------------------------------------
RUN DRIVER
-----------------------------------------------------------
"""

driver()