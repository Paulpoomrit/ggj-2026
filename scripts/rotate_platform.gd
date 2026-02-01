extends RigidBody2D
var rotation_rads = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(rotation_rads)

func _on_right_body_entered(body: Node2D) -> void:
	rotation_rads = PI/180 * 0.1
	print("test")


func _on_left_body_entered(body: Node2D) -> void:
	rotation_rads = -PI/180 * 0.1
	print("test")
