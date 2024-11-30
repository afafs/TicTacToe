extends MarginContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_window"):
		toggle_visibility()

func _on_button_button_down() -> void:
	toggle_visibility()

func toggle_visibility() -> void:
	visible = !visible
