extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PoofAnim.play("poof")
	await $PoofAnim.animation_finished
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
