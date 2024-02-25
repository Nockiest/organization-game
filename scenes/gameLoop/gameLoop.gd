extends Node2D


# Called when the node enters the scene tree for the first time.
func trackPlayerPos():
	return str(round($gameField/Objects/player.position.x )) + ' ' + str(round($gameField/Objects/player.position.y ))

func _ready() -> void:
	$Mdebug.track_value('player position',trackPlayerPos  ) 

func _on_game_field_area_entered(area: Area2D) -> void:
	print('area entered')
	for movement in get_tree().get_nodes_in_group('keyMovement'):
		movement.abort_movement()


func _on_game_field_area_exited(area: Area2D) -> void:
	print('area exited')
