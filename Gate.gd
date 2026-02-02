class_name Gate
extends RigidBody2D
var timer : Timer
var should_move = false
var direction = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	## GameManager.on_pressure_plate_state_changed.connect(on_pressure_plate_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass		

func on_pressure_plate_changed(is_enable: bool, target_platoform: Node) -> void:
	print("enable: ", is_enable)
	print("target: ", target_platoform)

	if is_enable:
		if target_platoform:
			target_platoform.queue_free()
