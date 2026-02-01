extends Control

func _ready():
	var lvlSelect=$PanelContainer/VBoxContainer/LvlSelect
	var popup=lvlSelect.get_popup()
	popup.id_pressed.connect(file_menu)


func file_menu(id):
	match(id):
		0:
			get_tree().change_scene_to_file("res://main_menu.tscn")
		1:
			get_tree().change_scene_to_file("res://main_menu.tscn")
		2:
			get_tree().change_scene_to_file("res://main_menu.tscn")
		3:
			get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_options_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
