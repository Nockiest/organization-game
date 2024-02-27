class_name GameField
extends Area2D

@export var spawn_delay_value = 0.25
func end_game():
	print('game ended') 

func spawn_new_wave():
	if len(Global.waves) <= Global.wave_number:
		end_game()
		return
	print('called')
	var shapes_per_wave = Global.waves[Global.wave_number] # Get shapes count for the current wave
	var spawn_delay = 0.1 # Initial spawn delay

	for i in range(shapes_per_wave):
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = spawn_delay
		timer.one_shot = true
		timer.start()
		timer.connect("timeout",  spawn_shape ) # Connect timeout signal to spawn_shape function
		spawn_delay += spawn_delay_value  # Increase spawn delay for the next shape
func spawn_shape( ):
	var shape_instance = Global.shape_scene.instantiate() # Load and instance the shape scene
	print($CollisionShape2D.shape.extents )
	print($CollisionShape2D.shape.extents[0] )
	print(shape_instance.size )
	var max_x = $CollisionShape2D.shape.extents.x * 2 - shape_instance.size 
	var random_x =  randi_range(0, max_x)
		
	shape_instance.position.x = random_x
	shape_instance.position.x =  randi_range(0, max_x -shape_instance.size  ) # Random x position
	shape_instance.position.y = -shape_instance.size 
	add_child(shape_instance)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 
	var extents =$CollisionShape2D.shape.extents 
 
	$Objects/player.allowed_movement[0] =  global_position 
	$Objects/player.allowed_movement[1] = global_position + Vector2(extents.x*2, extents.y*2)  
	#	print("Position:", position)
#	print("Extents:", extents)
#	print('x', [global_position,Vector2(extents.x*2, extents.y*2) ])
 
 


func _on_wave_delay_timeout() -> void:
#	spawn_new_wave()
	Global.wave_number += 1 
