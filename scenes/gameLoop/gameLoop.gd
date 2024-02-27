extends Node2D

 
var wave_number:= 0:
	set(value):
		print(wave_number)
		wave_number = value
		if wave_number < len(Global.waves):
			$gameField.spawn_new_wave()
		else:
			print('game ended no more waves to be spawned!')
# Called when the node enters the scene tree for the first time.
func trackPlayerPos():
	return str(round($gameField/Objects/player.position.x )) + ' ' + str(round($gameField/Objects/player.position.y ))
func trackScore():
	return str(Stats.game_score)
func trackWaveNumber():
	return str( wave_number)
func _ready() -> void:
	$Mdebug.track_value('player position',trackPlayerPos  ) 
	$Mdebug.track_value('score',trackScore  ) 
	$Mdebug.track_value('wave num',trackWaveNumber  ) 
 
 
func _on_shapes_child_exiting_tree(shape: Node) -> void:
	print( shape.get_parent().get_children(), 'children')
	var children = shape.get_parent().get_children()
 
	if len(children) == 1: # meaning that after the deletion of this shape the num would be 0
		print('wave number should increase')
		wave_number += 1
