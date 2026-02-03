extends Node


enum GAME_STATE {HAPPY, ANGRY, SAD}
enum LEVELS {LEVEL_ONE, LEVEL_TWO, LEVEL_THREE}


signal on_game_state_changed(state: GAME_STATE)
signal on_pressure_plate_state_changed(is_enable: bool, target_platoform: Node)
signal on_switch_to_level(level: LEVELS)

const level_ref: Dictionary[LEVELS, PackedScene] = {
	LEVELS.LEVEL_ONE: preload("uid://brhxug8pmagid"),
	LEVELS.LEVEL_TWO: preload("uid://b1pcykdp361ti"),
	LEVELS.LEVEL_THREE: preload("uid://bc0iahe7g074w")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	on_switch_to_level.connect(switch_to_level)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func switch_to_level(level: LEVELS) -> void:
	get_tree().change_scene_to_packed(level_ref[level])
