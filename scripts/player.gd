extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D
@onready var item_ui: ItemUI = $ItemUI
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_base_scale: Vector2 = animated_sprite_2d.scale


@export var bonce_particle_scene: PackedScene = preload("res://scenes/bounce_particles.tscn")
@export var switch_mask_particle_scene: PackedScene = preload("res://scenes/switch_mask_particles.tscn")

const SPEED = 600.0
const JUMP_VELOCITY = -1000.0
var state: int = 1
var was_on_floor = true


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
	
	# Spawn Particles
	var mask_particles = switch_mask_particle_scene.instantiate()
	self.add_child(mask_particles)
	mask_particles.global_position = self.global_position + Vector2(0, -75)

func handle_enemy_bouncing() -> void:
	if velocity.y <= 0:
		return
	if area.has_overlapping_areas():
		# print("colliding")
		velocity.y = JUMP_VELOCITY


func _physics_process(delta: float) -> void:
	handle_enemy_bouncing()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var just_jumped = false
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# print("JUMP PRESSED! State: ", state)
		match state:
			0: 
				animated_sprite_2d.play("jump_happy")
			2: 
				animated_sprite_2d.play("jump_sad")
			1: 
				animated_sprite_2d.play("jump_angry")
		velocity.y = JUMP_VELOCITY
		just_jumped = true
		animation_player.play("bounce")
	
	# Switch mask in the middle of jump action
	if not is_on_floor():
		match state:
			0: 
				animated_sprite_2d.play("jump_happy")
			2: 
				animated_sprite_2d.play("jump_sad")
			1: 
				animated_sprite_2d.play("jump_angry")
	
	# Movement
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
	
	# Landing
	if not was_on_floor and is_on_floor():
		animation_player.play("bounce")
		spawn_bounce_particles(self.get_position(), Vector2(1,0))
	was_on_floor = is_on_floor()
	
	
	# Collision updates
	var collision = move_and_collide(velocity * delta)
	if not collision:
		return
	var normal: Vector2 = collision.get_normal()
	spawn_bounce_particles(collision.get_position(), normal)


func _process(delta: float) -> void:
	set_scale_based_on_velocity()


### VISUALS ###
func set_scale_based_on_velocity() -> void:
	if animation_player.is_playing():
		return
	
	animated_sprite_2d.scale = lerp(sprite_base_scale, sprite_base_scale * Vector2(1.05, 1), velocity.length()/1600)


func spawn_bounce_particles(pos: Vector2, normal: Vector2) -> void:
	var instance = bonce_particle_scene.instantiate()
	get_tree().get_current_scene().add_child(instance)
	instance.global_position = pos
	instance.rotation = normal.angle()
	
