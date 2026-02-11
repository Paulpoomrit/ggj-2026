class_name Enemy

extends CharacterBody2D

@onready var player = get_node("../Player")
@onready var vis = $VisibleOnScreenNotifier2D
@onready var sound = $AudioStreamPlayer2D
const ENEMY_SPEED = 250

const POOF := preload("res://scenes/Poof.tscn")

var direction = 1:
	set(value):
		if motion_mode == MOTION_MODE_GROUNDED:
			$Sprite2D.flip_h = value > 0
		direction = value
var speed = 0
var start_position = position.x

var distance = 50

var current_mask = GameManager.GAME_STATE.HAPPY

func _ready() -> void:
	GameManager.on_game_state_changed.connect(handle_emotion_state_changed)
	


func handle_emotion_state_changed(state: GameManager.GAME_STATE) -> void:
	print(state)
	## do stuff
	match state:
		GameManager.GAME_STATE.HAPPY:
			current_mask = GameManager.GAME_STATE.HAPPY
			print("Game State: ", GameManager.GAME_STATE.HAPPY)
		GameManager.GAME_STATE.ANGRY:
			current_mask = GameManager.GAME_STATE.ANGRY
			print("Game State: ", GameManager.GAME_STATE.ANGRY)
		GameManager.GAME_STATE.SAD:
			current_mask = GameManager.GAME_STATE.SAD
			print("Game State: ", GameManager.GAME_STATE.SAD)
		_:
			current_mask = GameManager.GAME_STATE.HAPPY


func _physics_process(delta: float) -> void:
	# Add the gravity if ground enemy.
	if not is_on_floor() && motion_mode == MOTION_MODE_GROUNDED:
		velocity += get_gravity() * delta
		
	# early return if the player
	if player and player.position.distance_to(self.position) > 3000:
		return

	match current_mask:
		GameManager.GAME_STATE.HAPPY:
			if player == null:
				return
				
			var player_size_x = player.get_node("CollisionShape2D").shape.radius
			var player_pos_x = player.position.x + player_size_x

			if (position.x + 400 < player_pos_x):
				direction = 1
			elif (position.x - 400 > player_pos_x):
				direction = -1

			speed = ENEMY_SPEED
			velocity.x = speed * direction
			move_and_slide()
		GameManager.GAME_STATE.ANGRY:
			if player == null:
				return
			
			var player_size_x = player.get_node("CollisionShape2D").shape.radius
			
			var player_pos_x = player.position.x + player_size_x
			
			if (position.x + 200 <= player_pos_x):
				direction = -1
			else:
				direction = 1
			
			speed = ENEMY_SPEED
			velocity.x = speed * direction
			move_and_slide()
		GameManager.GAME_STATE.SAD:
			speed = 0
			velocity = Vector2(0,0)
		_:
			if (position.x <= start_position - distance):
				direction = 1
			if (position.x >= start_position + distance):
				direction = -1


func _on_area_2d_area_entered(area: Area2D) -> void:
	if motion_mode == MOTION_MODE_GROUNDED:
		sound.play()
		
		var poof := POOF.instantiate()
		poof.scale = Vector2(0.25, 0.25)
		poof.position += Vector2(0, -125)
		self.add_child(poof)
	
	
