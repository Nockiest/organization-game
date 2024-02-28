extends Node
const shape_scene:= preload("res://entities/shapes/shape.tscn")
var wave_number:= -1:
	set(value):
#		print('wave number changed', wave_number)
		wave_number = value
		if wave_number <  len(Global.waves) and wave_number >= 0:
			var game_field = get_tree().get_first_node_in_group("gamefields") 
			if game_field:
				game_field.spawn_new_wave()
			wave_duration_sec = waves[wave_number] * 10
		else:
			print('game ended no more waves to be spawned!')
			for timer in get_tree().get_nodes_in_group("wavetimers"):
				timer.stop()
			var rem_shapes = get_tree().get_nodes_in_group('shapes')
			if len(rem_shapes) == 0 and wave_number == len( waves):
#				should_change_scene = true
				get_tree().change_scene_to_file('res://scenes/end-screen/end-screen.tscn')
#			get_tree().change_scene_to_file("res://scenes/end-screen/end-screen.tscn") 
 
const waves := [
	2,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	12
]
var wave_duration_sec = 5:
	set(value):
		print('wave duration changed')
		for timer in get_tree().get_nodes_in_group("wavetimers"):
#			timer.queue_free()
			timer.stop()
			timer.wait_time = wave_duration_sec
			timer.start()
#
#	# Create a new Timer node
#		var timer = Timer.new()
#
#		# Set the delay of the Timer to wave_duration_sec
#		timer.wait_time = wave_duration_sec
#
#		# Connect the timeout signal of the Timer node
#		timer.connect("timeout",  _on_Timer_timeout )
#
#		# Add the Timer node as a child of the current node
#		add_child(timer)
#
#		# Add the Timer node to the "wavetimers" group
#		timer.add_to_group("wavetimers")
#
#		# Start the timer
#		timer.start()
#
#func _on_Timer_timeout():
#	for field in get_tree().get_nodes_in_group("gamefields"):
#		field.on_wave_delay_timeout()
	# Your code to handle the timer timeout goes here
 

func reset_values():
	wave_duration_sec = 5
	wave_number = -1 
	Stats.score = 0

		# call a function to call a new wave
