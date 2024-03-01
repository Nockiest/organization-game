extends Node2D


func trackPlayerPos()-> String:
	return str(round($gameField/Objects/player.position.x )) + ' ' + str(round($gameField/Objects/player.position.y ))
func trackScore()-> String:
	return str(Stats.game_score)
func trackWaveNumber()-> String:
	return str( Global.wave_number)
func trackShapeNum()-> String:
	return str(len($gameField/Objects/shapes.get_children()))
func trackHighScore()-> String:
	return str(Stats.highest_score)
func get_remaining_time() -> String:
	var timeNode = get_tree().get_first_node_in_group('wavetimers')
	if timeNode:
		return  str(round(timeNode.time_left))
	else:
		return 'time node doesnt exist'
func _ready() -> void:
	$Mdebug.track_value('player position',trackPlayerPos  )
	$Mdebug.track_value('score',trackScore  )
	$Mdebug.track_value('wave num',trackWaveNumber  )
	$Mdebug.track_value('till next turn',  get_remaining_time  )
	$Mdebug.track_value('shape num', trackShapeNum   )
	$Mdebug.track_value('shape num', trackHighScore   )
	$randomMusicPlayer.play_random_sound() 
 
func _on_shapes_child_exiting_tree(shape: Node) -> void:
	if len(shape.get_parent().get_children()) <= 1 and Global.wave_number >= len(Global.waves)-1:
		Global.end_game()
 
