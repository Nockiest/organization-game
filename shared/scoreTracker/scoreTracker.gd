extends Control


 
func _process(delta: float) -> void:
	$VBoxContainer/Score.text = 'Score: '+ str(Stats.game_score)
	if Stats.highest_score == float(-INF):
		$VBoxContainer/HighScore.text = 'HighScore: ' # Display nothing
	else:
		$VBoxContainer/HighScore.text = 'HighScore: ' + str(Stats.highest_score) # Display highest score

	$VBoxContainer/Wave.text =  'Wave Number: '+str(Global.wave_number)
	$VBoxContainer/TimeRemaining.text = 'Time Remaining : '+ get_tree().get_first_node_in_group('gameloops').get_remaining_time()
	$VBoxContainer/Shapes.text = 'Remaining Shapes : '+ get_tree().get_first_node_in_group('gameloops'). trackShapeNum()
