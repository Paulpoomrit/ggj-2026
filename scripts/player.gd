extends CharacterBody2D

@onready var area: Area2D = $Area2D 

const SPEED = 600.0
const JUMP_VELOCITY = -700.0

@onready var item_ui: ItemUI = $ItemUI


func _ready() -> void:
	pass

func handle_enemy_bouncing() -> void:

	if velocity.y <= 0:
		return

	# if there are no enemies' areas overlapping with "area", there are no enemies that the player can bounce on
	if area.has_overlapping_areas():
		print("colliding")
		velocity.y = JUMP_VELOCITY # make the player bounce upward


func _physics_process(delta: float) -> void:
	handle_enemy_bouncing()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
