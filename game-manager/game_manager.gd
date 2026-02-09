extends Node

enum GAME_STATE {HAPPY, ANGRY, SAD}
enum LEVELS {LEVEL_ONE, LEVEL_TWO, LEVEL_THREE}


signal on_game_state_changed(state: GAME_STATE)
signal on_pressure_plate_state_changed(is_enable: bool, target_platoform: Node)
signal on_switch_to_level(level: LEVELS)
signal on_camera_shake(duration: float, frequency: float, amplitude: float)

const level_ref: Dictionary[LEVELS, PackedScene] = {
	LEVELS.LEVEL_ONE: preload("res://levels/level_one.tscn"),
	LEVELS.LEVEL_TWO: preload("res://levels/level_two.tscn"),
	LEVELS.LEVEL_THREE: preload("res://levels/level_three.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_switch_to_level.connect(switch_to_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func switch_to_level(level: LEVELS) -> void:
	get_tree().change_scene_to_packed(level_ref[level])
