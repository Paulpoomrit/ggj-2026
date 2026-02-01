class_name DisappearingPlatform

 
extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	self.collision_enabled = false
	GameManager.on_pressure_plate_state_changed.connect(on_pressure_plate_state_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_pressure_plate_state_changed(should_open: bool, target_platform: Node):
	if target_platform != self:
		return
	self.visible = should_open
	self.collision_enabled = true
