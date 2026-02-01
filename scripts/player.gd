extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -700.0

@onready var item_ui: ItemUI = $ItemUI

var in_ui_mode = false

func _ready() -> void:
	item_ui.visible = false

func _physics_process(delta: float) -> void:
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

func enable_switch_ui(should_enable: bool):
	item_ui.visible = should_enable

func _unhandled_input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("switch_mask") and not in_ui_mode:
			enable_switch_ui(true)
			in_ui_mode = true
		elif Input.is_action_just_pressed("switch_mask") and in_ui_mode:
			enable_switch_ui(false)
			in_ui_mode = false
