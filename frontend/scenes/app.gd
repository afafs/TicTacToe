extends Control

var main_menu = preload("res://scenes/menu_main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu.instantiate()
	add_child(main_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
