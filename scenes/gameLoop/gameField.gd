class_name GameField
extends Area2D

 
func spawn_new_wave( ):
	var shapes_per_wave = get_parent().wave_number + 2 # Determining shapes per wave based on wave number
	var spawn_delay = 1.0 # Initial spawn delay
 
	for i in range(shapes_per_wave):
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = 1.0
		timer.start()
		timer.connect("timeout",  spawn_shape,  )
		spawn_delay -= 0.1 # Decrease spawn delay
func spawn_shape( ):
	var shape_instance = Global.shape_scene.instantiate() # Load and instance the shape scene
#	shape_instance.shape_type = Utils.get_random_enum_value(GameShapes.GameShapeTypes)
	print($CollisionShape2D.shape.extents )
	print($CollisionShape2D.shape.extents[0] )
	print(shape_instance.size )
	var max_x = $CollisionShape2D.shape.extents.x * 2 - shape_instance.size 
	var random_x =  randi_range(0, max_x)
		
	shape_instance.position.x = random_x
	shape_instance.position.x =  randi_range(0, max_x -shape_instance.size  ) # Random x position
	add_child(shape_instance)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
 
	var extents =$CollisionShape2D.shape.extents 
#	print("Position:", position)
#	print("Extents:", extents)
#	print('x', [global_position,Vector2(extents.x*2, extents.y*2) ])
	$Objects/player.allowed_movement[0] =  global_position 
	$Objects/player.allowed_movement[1] = global_position + Vector2(extents.x*2, extents.y*2)  
 
 
func spawn_wave():
	pass
