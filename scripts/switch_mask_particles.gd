extends GPUParticles2D


@export var emotion_state = GameManager.GAME_STATE


@export var happy_process_material: ParticleProcessMaterial
@export var angry_process_material: ParticleProcessMaterial
@export var sad_process_material: ParticleProcessMaterial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match emotion_state:
		GameManager.GAME_STATE.HAPPY:
			self.process_material = happy_process_material
		GameManager.GAME_STATE.ANGRY:
			self.process_material = angry_process_material
		GameManager.GAME_STATE.SAD:
			self.process_material = sad_process_material
	emitting = true
	$Timer.start(lifetime)



func _on_timer_timeout() -> void:
	queue_free()
