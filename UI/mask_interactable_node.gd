extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# listen for the event 'emotion_state_changed' from  the game manager
	# and connect it to the call back func 'handle_emotion_state_changed'
	GameManager.on_game_state_changed.connect(handle_emotion_state_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func handle_emotion_state_changed(state: GameManager.GAME_STATE) -> void:
	print(state)
	## do stuff
