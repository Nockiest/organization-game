class_name StartScreen
extends Control

 

func _on_show_description_pressed() -> void:
	Utils.show_and_hide( $description , $"base-screen" )


func _on_return_pressed() -> void:
	Utils.show_and_hide($"base-screen" ,$description )


func _on_end_game_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_start_game_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/gameLoop/gameLoop.tscn") 
