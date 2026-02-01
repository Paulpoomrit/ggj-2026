extends Node


const ClickSounds: Array[AudioStream] = [
	preload("uid://bwgxegbup4qaf"),
	preload("uid://d1v53u2aeeaun"),
	preload("uid://br7mf7e6peods"),
	preload("uid://cngssuag03n2i"),
	preload("uid://crlq6053wxb5w"),
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func play_click_sfx(player: AudioStreamPlayer) -> void:
	player.stop()
	player.stream = ClickSounds.pick_random()
	player.play()
