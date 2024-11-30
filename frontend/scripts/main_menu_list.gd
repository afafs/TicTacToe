extends VBoxContainer

@export var margin: int

var selected_game_mode: int

func _ready() -> void:
	
	resize(margin)
	_connect_page_buttons()
	_connect_game_mode_buttons()
	_connect_game_type_buttons()


func resize(new_margin: int):
	margin = new_margin
	var vboxes = find_children("*", "VBoxContainer")
	for box in vboxes:
		box.add_theme_constant_override("separation", margin)
	
	var badge_entries = find_children("BadgeEntry", "HBoxContainer")
	
	%BadgesList. add_theme_constant_override("separation", margin)
	for badge in badge_entries:
		badge.add_theme_constant_override("separation", margin)


func _connect_page_buttons():
	var page_buttons = %ButtonsBar.get_children()
	for button in page_buttons:
		button.connect("button_up", _change_page.bind(button.get_index()))


func _change_page(page_index: int):
	%MenuPages.current_tab = page_index


func _connect_game_mode_buttons():
	var game_mode_buttons = %GameModesList.get_children()
	for button in game_mode_buttons:
		button.connect("button_up", _set_game_mode.bind(button.get_index()))


func _connect_game_type_buttons():
	var game_type_buttons = %GameTypesList.get_children()
	for button in game_type_buttons:
		button.connect("button_up", _start_game.bind(button.get_index()))


func _set_game_mode(index: int):
	selected_game_mode = index
	%GameModesList.visible = false
	%GameTypesList.visible = true


func _start_game(game_type: int):
	match selected_game_mode:
		0:
			print("Ultimate")
		1:
			print("Normal")
	match game_type:
		0:
			print("Online")
		1:
			print("Private")
		2:
			print("Local")
		3:
			print("Blitz")
		4:
			print("Offline")
	var game_manager_scene = load("res://scenes/Game.tscn")
	var game_manager = game_manager_scene.instantiate()
	game_manager.margin = margin
	add_sibling(game_manager)
	queue_free()
