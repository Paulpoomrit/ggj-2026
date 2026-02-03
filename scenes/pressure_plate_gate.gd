extends Area2D

@export var target_object: Gate = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if target_object == null:
		return
	target_object.on_pressure_plate_changed(true, target_object)
