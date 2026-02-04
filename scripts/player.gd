extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D
@onready var item_ui: ItemUI = $ItemUI

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
var state: int = 1


func _ready() -> void:
	GameManager.on_game_state_changed.connect(_on_game_state_changed)

func _on_game_state_changed(game_state: GameManager.GAME_STATE) -> void:
	match game_state:
		GameManager.GAME_STATE.HAPPY:
			state = 0
		GameManager.GAME_STATE.SAD:
			state = 2
		GameManager.GAME_STATE.ANGRY:
			state = 1

func handle_enemy_bouncing() -> void:
	if velocity.y <= 0:
		return
	if area.has_overlapping_areas():
		print("colliding")
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	handle_enemy_bouncing()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var just_jumped := false
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print("JUMP PRESSED! State: ", state)
		match state:
			0: 
				animated_sprite_2d.play("jump_happy")
			2: 
				animated_sprite_2d.play("jump_sad")
			1: 
				animated_sprite_2d.play("jump_angry")
		velocity.y = JUMP_VELOCITY
		just_jumped = true
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
		if is_on_floor() and not just_jumped:
			match state:
				0: animated_sprite_2d.play("walk_happy")
				2: animated_sprite_2d.play("walk_sad")
				1: animated_sprite_2d.play("walk_angry")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not just_jumped:
			match state:
				0: animated_sprite_2d.play("idle_happy")
				2: animated_sprite_2d.play("idle_sad")
				1: animated_sprite_2d.play("idle_angry")
	
	move_and_slide()
