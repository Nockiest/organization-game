class_name GameField
extends Area2D

@export var spawn_delay_value = 0.25

func spawn_new_wave():
	var shapes_per_wave = Global.waves[Global.wave_number] # Get shapes count for the current wave
	var spawn_delay = 0.1 # Initial spawn delay
	print(shapes_per_wave, 'shapes for wave')
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
#	print($CollisionShape2D.shape.extents )
#	print($CollisionShape2D.shape.extents[0] )
#	print(shape_instance.size )
	var max_x = $CollisionShape2D.shape.extents.x * 2 - shape_instance.size
	var random_x =  randi_range(0, max_x)
	var intersects = true
	while intersects:
		var shapes = $Objects/shapes.get_children()
		var found = false
		for shape in shapes:
#			Geometry2D.is_point_in_polygon(random_x, global_vertices)
#			if shape.get_global_rect().intersects(random_x):
			if !Utils.calculate_is_inside(Utils.collision_shape_to_polygon(shape.get_node('CollisionShape2D')), Vector2(random_x, 0)):
				# If there's a collision, return without spawning the shape
				random_x = randi_range(0, max_x)
				break
		if not found:
			intersects = false
	shape_instance.position.x = random_x
	shape_instance.position.x =  randi_range(shape_instance.size , max_x -shape_instance.size  ) # Random x position
	shape_instance.position.y = -shape_instance.size
	$Objects/shapes.add_child(shape_instance)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var extents =$CollisionShape2D.shape.extents

	$Objects/player.allowed_movement[0] =  global_position
	$Objects/player.allowed_movement[1] = global_position + Vector2(extents.x*2, extents.y*2)
	#	print("Position:", position)
#	print("Extents:", extents)
#	print('x', [global_position,Vector2(extents.x*2, extents.y*2) ])




func on_wave_delay_timeout() -> void:
#	spawn_new_wave()
	Global.wave_number += 1
