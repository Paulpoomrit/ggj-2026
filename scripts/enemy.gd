extends CharacterBody2D

var direction = 1
var speed = 1000.0
var distance = 10
var start_position = position.x


func _physics_process(delta: float) -> void:
	#start_position = position.x
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = speed * direction * delta
	
	if (position.x <= start_position - distance):
		direction = 1
	if (position.x >= start_position + distance):
		direction = -1
	
	move_and_slide()
