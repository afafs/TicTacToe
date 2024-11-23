extends TabContainer

var resolution
var game_modes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_modes = %GameModes.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	resolution = get_viewport_rect().size
	for mode in game_modes:
		mode.custom_minimum_size.x = resolution.x / 3
		mode.custom_minimum_size.y = resolution.y / 10
