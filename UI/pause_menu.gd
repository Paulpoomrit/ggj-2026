extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	hide()


func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	await get_tree().create_timer(0.3).timeout
	hide()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	show()

func testPause():
	if Input.is_action_just_pressed("pause") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true:
		resume()
	


func _on_resume_pressed():
	resume()


func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _process(_delta):
	testPause()
