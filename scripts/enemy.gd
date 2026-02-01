extends CharacterBody2D

@onready var vis = $VisibleOnScreenNotifier2D
const ENEMY_SPEED = 100

var direction = 1
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
		GameManager.GAME_STATE.ANGRY:
			current_mask = GameManager.GAME_STATE.ANGRY
		GameManager.GAME_STATE.SAD:
			current_mask = GameManager.GAME_STATE.SAD
		_:
			current_mask = GameManager.GAME_STATE.HAPPY


func _physics_process(delta: float) -> void:
	# Add the gravity if ground enemy.
	if not is_on_floor() && motion_mode == MOTION_MODE_GROUNDED:
		velocity += get_gravity() * delta
	
	match current_mask:
		GameManager.GAME_STATE.HAPPY:
			var player = get_node("../Player")
			var player_radius = player.get_node("CollisionShape2D").shape.radius
			var player_pos_x = player.position.x + player_radius

			if (position.x <= player_pos_x):
				direction = 1
			else:
				direction = -1

			speed = ENEMY_SPEED
			velocity.x = speed * direction
			move_and_slide()
		GameManager.GAME_STATE.ANGRY:
			var player = get_node("../Player")
			var player_radius = player.get_node("CollisionShape2D").shape.radius
			
			var player_pos_x = player.position.x + player_radius
			
			if (position.x <= player_pos_x):
				direction = -1
			else:
				direction = 1
			
			speed = ENEMY_SPEED
			velocity.x = speed * direction
			move_and_slide()
		GameManager.GAME_STATE.SAD:
			speed = 0
		_:
			if (position.x <= start_position - distance):
				direction = 1
			if (position.x >= start_position + distance):
				direction = -1
			
			
			
	
