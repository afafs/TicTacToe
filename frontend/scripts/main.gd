extends Control

@export var first_login = false
@export var margin = 32

@onready var login_list_scene = load("res://scenes/LoginList.tscn")

var safe_area_top = 0
var safe_area_sides = 0


func _ready() -> void:
	_clear_children()
	_get_safe_area()
	_handle_screen_resize()
	if first_login:
		_first_login()
	else:
		_login()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_get_safe_area()
		_handle_screen_resize()


func _handle_screen_resize():
	add_theme_constant_override("margin_top", safe_area_top + margin)
	add_theme_constant_override("margin_bottom", safe_area_top + margin)
	add_theme_constant_override("margin_left", safe_area_sides + margin)
	add_theme_constant_override("margin_right", safe_area_sides + margin)
	if get_child_count() > 0:
		find_children("*", "VBoxContainer").resize(margin)


func _get_safe_area() -> void:
	var os_name = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		# Publicize device type
		#var _screen_size = get_viewport_rect().size
		var safe_area = DisplayServer.get_display_safe_area()
		safe_area_top = safe_area.position.y
		safe_area_sides = safe_area.position.x
		if os_name == "iOS":
			var screen_scale = DisplayServer.screen_get_scale()
			safe_area_top = (safe_area_top / screen_scale)
			safe_area_sides = (safe_area_sides / screen_scale)


func _clear_children():
	var children = get_children()
	for child in children:
		child.queue_free()


func _connect_buttons(buttons: Array):
	print("buttons: ", buttons)
	for button: Button in buttons:
		match button.name:
			"Confirm":
				button.connect("button_up", _login)
			"Login":
				button.connect("button_up", _login)
			"LoginGoogle":
				button.connect("button_up", _login_google.bind(button))
			"LoginGuest":
				button.connect("button_up", _login)


func _first_login() -> void:
	var login_list = login_list_scene.instantiate()
	login_list.margin = 32
	add_child(login_list)
	_connect_buttons(login_list.find_children("*", "Button"))


func _login() -> void:
	_clear_children()
	var main_menu_scene = load("res://scenes/MainMenuList.tscn")
	var main_menu_list = main_menu_scene.instantiate()
	main_menu_list.margin = 32
	add_child(main_menu_list)


func _login_google(button: Button) -> void:
	button.text = "Not available"


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()

######################
### FOR DEBUG ONLY ###
######################
#func _process(_delta: float) -> void:
	#%TopMarginSize.text = "Top Margin: " + str(safe_area_top + margin)
	#%TopBarSize.text = "Top Bar: " + str(%TopBar.size)
	#%MarginSize.text = "Margin: " + str(margin)
	#%MainAreaSize.text = "Main Area: " + str(%MainArea.size)
	#%ButtonsBarSize.text = "Buttons Bar: " + str(%ButtonsBar.size)
	#%ButtonSize.text = "Button: " + str(%Button.size)
