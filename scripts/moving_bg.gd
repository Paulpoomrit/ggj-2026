extends Sprite2D


var tween: Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.on_game_state_changed.connect(emotion_state_changed)


func emotion_state_changed(state: GameManager.GAME_STATE) -> void:
	const zoom_value = 2
	
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(material, "shader_parameter/size_scale", zoom_value, 0.15).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(material, "shader_parameter/size_scale", 1, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

	
