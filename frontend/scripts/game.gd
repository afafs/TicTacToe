extends Node

@export var margin: int
@export var safe_area: Vector2


func _ready() -> void:
	get_viewport().connect("size_changed", _on_viewport_resize)
	get_safe_area()
	%GameBoard.scale = Vector2(0.9, 0.9)
	%GameBoard.position = safe_area / 2
	_set_margins(margin)


func _on_viewport_resize() -> void:
	get_safe_area()
	%GameBoard.position = safe_area / 2

func get_safe_area() -> void:
	var os_name = OS.get_name()
	if os_name == "Android" || os_name == "iOS":
		#var _screen_size = get_viewport_rect().size
		safe_area = DisplayServer.get_display_safe_area().size
		if os_name == "iOS":
			var screen_scale = DisplayServer.screen_get_scale()
			safe_area = Vector2(safe_area.x / screen_scale, safe_area.y / screen_scale)
	else:
		safe_area =  get_child(0).get_viewport_rect().size


func _set_margins(new_margin: int):
	var margin_containers = find_children("*", "MarginContainer")
	for cont in margin_containers:
		cont.add_theme_constant_override("margin_bottom", new_margin * 2)
		cont.add_theme_constant_override("margin_top", new_margin * 2)
		cont.add_theme_constant_override("margin_left", new_margin * 2)
		cont.add_theme_constant_override("margin_right", new_margin * 2)
		get_child(0).add_theme_constant_override("separation", margin)
