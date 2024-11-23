extends HBoxContainer

@onready var menu_tab_container = %Menu_TabContainer

func _ready() -> void:
	for c in get_child_count():
		print("child: ", c, ",", get_child(c))
		var child = get_child(c)
		child.button_down.connect(_on_button_down.bind(c))


func _on_button_down(index: int):
	menu_tab_container.current_tab = index
