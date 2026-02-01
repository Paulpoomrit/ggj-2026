extends Control
class_name ItemUI

signal mask_selected(index: int)
signal mask_changed(index: int)

@export var arc_radius: float = 200.0
@export var arc_angle_span: float = 90.0
@export var scroll_speed: float = 10.0

@onready var item_container: Control = $ItemContainer

var slots: Array[Control] = []
var current_index: int = 0
var target_index: int = 0
var scroll_offset: float = 0.0
var is_scrolling: bool = false

func _ready() -> void:
	for child in item_container.get_children():
		if child is Control:
			slots.append(child)
	_update_positions(true)

func _process(delta: float) -> void:
	
	if is_scrolling:
		scroll_offset = lerp(scroll_offset, float(target_index), delta * scroll_speed)
		if abs(scroll_offset - target_index) < 0.01:
			scroll_offset = float(target_index)
			current_index = target_index
			is_scrolling = false
			mask_changed.emit(current_index)
		_update_positions(false)

func convert_index_game_state(index: int):
	match index:
		0:
			return GameManager.GAME_STATE.HAPPY
		1:
			return GameManager.GAME_STATE.ANGRY
		2:
			return GameManager.GAME_STATE.SAD
		_:
			return null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				scroll_previous()
				get_viewport().set_input_as_handled()
			MOUSE_BUTTON_WHEEL_DOWN:
				scroll_next()
				#get_viewport().set_input_as_handled()
			KEY_ENTER:
				mask_selected.emit(target_index)
				print("Mask selected: ", target_index)
				var game_state: GameManager.GAME_STATE = convert_index_game_state(target_index)
				
				GameManager.on_game_state_changed.emit(game_state)
				#get_viewport().set_input_as_handled()

func _update_positions(immediate: bool) -> void:
	if slots.size() < 1:
		return
	
	var center_x = size.x / 2.0
	var center_y = size.y + arc_radius * 0.2
	var angle_per_item = arc_angle_span / max(slots.size() - 1, 1)
	
	for i in range(slots.size()):
		var slot = slots[i]
		var slot_index = float(i) - scroll_offset
		
		var angle_offset = slot_index * angle_per_item
		var angle_rad = deg_to_rad(-90.0 + angle_offset)
		
		var dist = abs(slot_index)
		
		var target_scale: float
		var target_y_offset: float = 0.0
		
		if dist < 0.5:
			target_scale = 2.5
			target_y_offset = -40.0
		else:
			target_scale = lerp(1.0, 0.7, clamp(dist / 2.0, 0.0, 1.0))
		
		var target_alpha = lerp(1.0, 0.5, clamp(dist / 2.0, 0.0, 1.0))
		
		var target_pos = Vector2(
			center_x + cos(angle_rad) * arc_radius - slot.size.x / 2.0,
			center_y + sin(angle_rad) * arc_radius - slot.size.y / 2.0 + target_y_offset
		)
		
		if immediate:
			slot.position = target_pos
			slot.scale = Vector2(target_scale, target_scale)
			slot.modulate.a = target_alpha
		else:
			slot.position = slot.position.lerp(target_pos, 0.25)
			slot.scale = slot.scale.lerp(Vector2(target_scale, target_scale), 0.25)
			slot.modulate.a = lerp(slot.modulate.a, target_alpha, 0.25)
		
		var glow = slot.get_node_or_null("Glow")
		if glow:
			glow.modulate.a = 1.0 if dist < 0.5 else 0.0
		
		slot.z_index = 100 - int(dist * 10)

func scroll_next() -> void:
	if target_index < slots.size() - 1:
		target_index += 1
		is_scrolling = true

func scroll_previous() -> void:
	if target_index > 0:
		target_index -= 1
		is_scrolling = true

#func get_selected_index() -> int:
	#return current_index
