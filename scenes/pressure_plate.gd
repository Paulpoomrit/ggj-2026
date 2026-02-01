extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


@export var target_object: Node = null


# is enable when some thing is colliding
var is_enable = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.on_pressure_plate_state_changed.emit(false, target_object)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	is_enable = true
	if target_object:
		GameManager.on_pressure_plate_state_changed.emit(is_enable, target_object)


func _on_body_exited(body: Node2D) -> void:
	is_enable = false
	if target_object:
		GameManager.on_pressure_plate_state_changed.emit(is_enable, target_object)
