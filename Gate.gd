extends RigidBody2D
var timer : Timer
var should_move = false
var direction = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_0):
		should_move = true
		direction = true
		timer.start()
	if Input.is_key_pressed(KEY_1):
		should_move = true
		direction = false
		timer.start()
		
	_move()


func _on_timer_timeout() -> void:
	should_move = false
	
func _move():
	if should_move:
		if direction:
			move_local_y(3)
		else:
			move_local_y(-3)
