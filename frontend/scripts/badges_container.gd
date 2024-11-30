extends ScrollContainer

const BADGE_ENTRY = preload("res://scenes/BadgeEntry.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for badge in range(20):
		var new_badge = BADGE_ENTRY.instantiate()
		get_child(0).add_child(new_badge)
