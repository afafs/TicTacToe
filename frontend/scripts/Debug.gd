extends MarginContainer

var menu_tabs
var resolution_label
var fps_label

func _ready() -> void:
	menu_tabs = $"../Menu_Main/Menu_TabContainer"
	
	resolution_label = %Resolution
	fps_label = %FPS


func _process(_delta: float) -> void:
	position.y = menu_tabs.position.y
	
	resolution_label.text = "Resolution: " + str(get_viewport_rect().size)
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second()) + " Hz"


func _input(event):
	if event.is_action_pressed("debug"):
		visible = !visible
