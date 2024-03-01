extends Control
 
var play_count = 0

 
 
func _on_audio_finished():
	# Increment the play count
	play_count += 1
	print("Audio played ", play_count, " times.")
func _on_button_pressed() -> void:
	Global.reset_values()
	get_tree().change_scene_to_file("res://scenes/start-screen/start-screen.tscn") 
 
func _on_button_2_pressed() -> void:
	Utils.exit_game()

func _ready() -> void:
	$gameEnded.connect("finished",  _on_audio_finished )
	if play_count == 0:
		$gameEnded.play()
	$score.text = 'Score:' + str(Stats.game_score)
	$highScore.text = 'High Score:' + str(Stats.highest_score)
