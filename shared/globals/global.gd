extends Node
const shape_scene:= preload("res://entities/shapes/shape.tscn")
var wave_number:= -1:
	set(value):
 
		wave_number = value
 
		if wave_number <  len(Global.waves)  :
			var game_field = get_tree().get_first_node_in_group("gamefields")
			if game_field:
				game_field.spawn_new_wave()
			wave_duration_sec = waves[wave_number] * 1
		else:
			print('game ended no more waves to be spawned!')
			for timer in get_tree().get_nodes_in_group("wavetimers"):
				timer.stop()
#			end_game()
var high_score = 0
const waves := [
	2,
	4,
#	5,
#	6,
#	7,
#	8,
#	9,
#	10,
#	12
]
var wave_duration_sec = 5:
	set(value):
		for timer in get_tree().get_nodes_in_group("wavetimers"):
			timer.queue_free()
		var gameloop  = get_tree().get_first_node_in_group("gameloops") 
		if gameloop:
			var new_timer = Timer.new()
			new_timer.wait_time = value
			wave_duration_sec=value
			new_timer.autostart = true
			gameloop.add_child(new_timer)
			new_timer.connect("timeout",  _on_wave_timeout )
			new_timer.add_to_group("wavetimers")
func _on_wave_timeout() -> void:
	Global.wave_number += 1
 


func reset_values():
	wave_duration_sec = 5
	wave_number = -1
	Stats.game_score = 0

  
 
const SAVEFILE:String = "user://savefile.save"
 
func end_game():
#	print(Stats.game_score)
	await  get_tree().create_timer(2).timeout 
	var game_score_number = float(Stats.game_score)
	var highest_score_number = float(Stats.highest_score)
 
	Stats.highest_score = max(game_score_number, highest_score_number)
	save_score()
	get_tree().change_scene_to_file("res://scenes/end-screen/end-screen.tscn")

func _ready():
	load_score()
 
func save_score():
	pass
#	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
#	file.store_32(Stats.highest_score)
#	file = null
 
func load_score():
	pass
#	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
#	if FileAccess.file_exists(SAVEFILE):
#		print(file.get_32())
#		Stats.highest_score = str(file.get_32())
#	file = null
