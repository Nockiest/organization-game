extends Control
 
func _on_button_pressed() -> void:
	Global.reset_values()
	get_tree().change_scene_to_file("res://scenes/start-screen/start-screen.tscn") 
 
func _on_button_2_pressed() -> void:
	Utils.exit_game()
