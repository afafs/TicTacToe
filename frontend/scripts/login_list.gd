extends VBoxContainer

@export var margin: int
@export var buttons: Array

# Backend URL for user registration
const BACKEND_REGISTER_URL = "http://localhost:5001/api/users/register"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttons = find_children("*", "Button")
	resize(margin)


func resize(new_margin: int) -> void:
	margin = new_margin
	add_theme_constant_override("separation", margin * 2)
	%LoginButtons.add_theme_constant_override("separation", margin * 2)
	%SignupButtons.add_theme_constant_override("separation", margin * 2)
	
	var textboxes = find_children("*", "TextEdit")
	var button_padding = margin * 2
	var min_button_width = get_viewport_rect().size.x / 2
	
	for button in buttons:
		button.custom_minimum_size.x = min_button_width - (button_padding * 2)
		# Set button vertical size to textbox vertical size
		button.custom_minimum_size.y = textboxes[0].size.y
	
	for textbox in textboxes:
		textbox.custom_minimum_size.x = min_button_width + button_padding

func _on_sign_up_button_up() -> void:
	%LoginButtons.visible = false
	%PasswordRetype.visible = true
	%SignupButtons.visible = true

func _on_back_button_up() -> void:
	%LoginButtons.visible = true
	%PasswordRetype.visible = false
	%SignupButtons.visible = false

# Function to handle user registration
func _on_confirm_button_up() -> void:
	print("Firs")
	# Get user input from textboxes
	var email = %Username.text
	var password = %Password.text
	var password_retype = %PasswordRetype.text

	# Validate user input
	if email == "" or password == "":
		print("email1")
		show_error("Email and password cannot be empty.")
		return
	if password != password_retype:
		print("email")
		show_error("Passwords do not match.")
		return
	print("afaf")
	# Create JSON payload for backend
	var payload = {"email": email, "password": password}
	var json_payload = to_json(payload)
	print(json_payload)
	# Make HTTP request
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	#http_request.request(BACKEND_REGISTER_URL, [], HTTPClient.METHOD_POST, json_payload)
	http_request.request(BACKEND_REGISTER_URL, ["Content-Type: application/json"], HTTPClient.METHOD_POST, json_payload)

# Handle HTTP response
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray):
	var response_text = body.get_string_from_utf8()
	print("Response text:", response_text)
	var json = JSON.new()
	var parse_result = json.parse(response_text)
	
	if parse_result != OK:
		print("Failed to parse JSON")
		show_error("An error occurred while processing the server response.")
		return
		
	var response_data = json.data  # Access the parsed JSON object
	if response_code == 201:
		show_message("Registration successful!")
	else:
		var error_message = response_data.get("message", "Registration failed.")
		print("Registration failed:", error_message)
		show_error(error_message)


# Display error messages
func show_error(message: String) -> void:
	$ErrorMessage.text = "[color=red]" + message + "[/color]"
	$ErrorMessage.visible = true

# Display success messages
func show_message(message: String) -> void:
	$ErrorMessage.text = "[color=green]" + message + "[/color]"
	$ErrorMessage.visible = true

# Convert a dictionary to JSON string
func to_json(data: Dictionary) -> String:
	var json = JSON.new()
	return json.stringify(data)


func _on_button_pressed() -> void:
	print("Firs")
	# Get user input from textboxes
	var email = %Username.text
	var password = %Password.text
	var password_retype = %PasswordRetype.text

	# Validate user input
	if email == "" or password == "":
		print("email1")
		show_error("Email and password cannot be empty.")
		return
	if password != password_retype:
		print("email")
		show_error("Passwords do not match.")
		return
	print("afaf")
	# Create JSON payload for backend
	var payload = {"email": email, "password": password}
	var json_payload = to_json(payload)
	print(json_payload)

	# Make HTTP request
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	http_request.request(BACKEND_REGISTER_URL,  ["Content-Type: application/json"], HTTPClient.METHOD_POST, json_payload)
