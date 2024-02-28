extends Node
 
var wave_number:= 0:
	set(value):
		print(wave_number)
		wave_number = value
		if wave_number < len(Global.waves):
			var game_field = get_tree().get_first_node_in_group("gamefields") 
			if game_field:
				game_field.spawn_new_wave()
			wave_duration_sec = waves[wave_number] * 2.5
		else:
			print('game ended no more waves to be spawned!')
			get_tree().change_scene_to_file("res://scenes/end-screen/end-screen.tscn") 
var waves = [
	3,
#	5,
#	8,
#	11,
#	14,
#	18,
#	21,
#	24,
#	40
]
var wave_duration_sec = 5:
	set(value):
		for timer in get_tree().get_nodes_in_group("wavetimers"):
			timer.wait_time = value
const shape_scene:PackedScene = preload("res://entities/shapes/shape.tscn")

func reset_values():
	wave_duration_sec = 5
	wave_number = 0 
 
		# call a function to call a new wave
