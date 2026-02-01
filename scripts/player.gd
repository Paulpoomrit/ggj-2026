extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player_sprite_node: AnimatedSprite2D = $AnimatedSprite2D/AnimatedSprite2D
@onready var area: Area2D = $Area2D
#var index: GameManager.GAME_STATE
const SPEED = 600.0
const JUMP_VELOCITY = -700.0
const collision_right_x = 45
const collision_left_x = -45

func _ready() -> void:
	GameManager.on_game_state_changed.connect(change_mood)
	pass
	
@onready var item_ui: ItemUI = $ItemUI


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
		animated_sprite_2d.play("jump")
		velocity.y = JUMP_VELOCITY
    
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		animated_sprite_2d.play("walk")
		velocity.x = direction * SPEED
		animated_sprite_2d.scale.x = 1
		#animated_sprite_2d.flip_h = direction < 0
		animated_sprite_2d.flip_h = direction < 0
		player_sprite_node.flip_h = direction < 0 
		if velocity.x < 0:
			player_sprite_node.set_offset(Vector2(-450,0))
		else:
			player_sprite_node.set_offset(Vector2(+0,0))
	else:
		animated_sprite_2d.play("slow_down")
		animated_sprite_2d.scale.x = -1
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#animated_sprite_2d.stop()

	move_and_slide()


func _on_item_ui_mask_changed(index: int) -> void:
	match index:
		0:
			player_sprite_node.play("HAPPY")
		1:
			player_sprite_node.play("SAD")
		2:
			player_sprite_node.play("ANGRY")

func change_mood(emotion: GameManager.GAME_STATE):
	match emotion:
		GameManager.GAME_STATE.HAPPY:
			player_sprite_node.play("HAPPY")
		GameManager.GAME_STATE.SAD:
			player_sprite_node.play("SAD")
		GameManager.GAME_STATE.ANGRY:
			player_sprite_node.play("ANGRY")
	
