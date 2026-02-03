extends Area2D

@export var level : GameManager.LEVELS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().name == "Player":
		# let the game manager handle level switching logic
		# so that we don't need a direct ref to the level
		# and just pass in an enum
		GameManager.on_switch_to_level.emit(level)
