extends Node2D


func trackPlayerPos():
	return str(round($gameField/Objects/player.position.x )) + ' ' + str(round($gameField/Objects/player.position.y ))
func trackScore():
	return str(Stats.game_score)
func trackWaveNumber():
	return str( Global.wave_number)
func trackShapeNum():
	return str(len($gameField/Objects/shapes.get_children()))

func _ready() -> void:
	$Mdebug.track_value('player position',trackPlayerPos  )
	$Mdebug.track_value('score',trackScore  )
	$Mdebug.track_value('wave num',trackWaveNumber  )
	$Mdebug.track_value('till next turn', $WaveDelay.get_remaining_time  )
	$Mdebug.track_value('shape num', trackShapeNum   )

func _on_shapes_child_exiting_tree(shape: Node) -> void:

	if len(shape.get_parent().get_children()) <= 1 and Global.wave_number >= len(Global.waves)-1:

		end_game()
func end_game():
	get_tree().change_scene_to_file("res://scenes/end-screen/end-screen.tscn")
