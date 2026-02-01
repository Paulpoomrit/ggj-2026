extends Node


enum GAME_STATE {HAPPY, ANGRY, SAD}


signal on_game_state_changed(state: GAME_STATE)
signal on_pressure_plate_state_changed(is_enable: bool, target_platoform: Node)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
