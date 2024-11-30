extends VBoxContainer


@export var margin: int
@export var buttons: Array


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


# Show Retype Password textbox
func _on_back_button_up() -> void:
	%LoginButtons.visible = true
	%PasswordRetype.visible = false
	%SignupButtons.visible = false
