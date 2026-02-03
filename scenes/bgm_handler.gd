extends Node2D
@onready var main_bgm = $AudioStreamPlayer2D
@onready var dynamic_bgm = $AudioStreamPlayer2D/AudioTopLayer
@onready var happy_bgm = load("res://assets/Sound/Happy - v1.ogg")
@onready var sad_bgm = load("res://assets/Sound/Sad - v1.ogg")
@onready var angry_bgm = load("res://assets/Sound/Angry - v2.ogg")

var playback : AudioStreamPlaybackPolyphonic

var current_stream_ID = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.on_game_state_changed.connect(switch_music)
	dynamic_bgm.play()
	playback = dynamic_bgm.get_stream_playback()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_music(state) -> void:
	playback.stop_stream(current_stream_ID)
	
	var song_selection
	
	match state:
		GameManager.GAME_STATE.HAPPY:
			song_selection = happy_bgm
		GameManager.GAME_STATE.ANGRY:
			song_selection = angry_bgm
		GameManager.GAME_STATE.SAD:
			song_selection = sad_bgm
			
	current_stream_ID = playback.play_stream(song_selection,main_bgm.get_playback_position(),.6)
