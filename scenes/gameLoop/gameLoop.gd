extends Node2D

const shape_scene:PackedScene = preload("res://entities/shapes/shape.tscn")
var wave_number:= 0:
	set(value):
		wave_number = value
		if wave_number < len(Global.waves):
			spawn_new_wave()
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
 
func spawn_new_wave( ):
	var shapes_per_wave = wave_number + 2 # Determining shapes per wave based on wave number
	var spawn_delay = 1.0 # Initial spawn delay
	var random = RandomNumberGenerator.new() # Random number generator
	
	for i in range(shapes_per_wave):
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.start()
#		shape_instance.shape_type = get_random_shape_type() # Set random shape type
		# Add the instance to scene and apply spawn delay
		timer.connect("timeout",  spawn_shape,  )
		# Update spawn delay for next shape
		spawn_delay -= 0.1 # Decrease spawn delay
func spawn_shape( ):
	var shape_instance = shape_scene.instantiate() # Load and instance the shape scene
	shape_instance.position.x =  randi_range(-300, 300) # Random x position
	add_child(shape_instance)
func _on_shapes_child_exiting_tree(shape: Node) -> void:
	print( shape.get_parent().get_children(), 'children')
	var children = shape.get_parent().get_children()
 
	if len(children) == 1: # meaning that after the deletion of this shape the num would be 0
		print('wave number should increase')
		wave_number += 1
