class_name GameField
extends Area2D

@export var spawn_delay_value = 0.25

func spawn_new_wave():
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
	$Objects/shapes.add_child(shape_instance)
	var max_x = $CollisionShape2D.shape.extents.x * 2 - shape_instance.size
	var random_x =  randi_range(global_position.x, max_x) +shape_instance.size
#	var intersects = false
	shape_instance.shape_color = Utils.get_random_enum_value(Colors.GameColors,[Colors.GameColors.GRAY] )
	shape_instance.global_position.x = random_x
	shape_instance.global_position.y = -shape_instance.size
 
#func _ready() -> void:
#	var extents =$CollisionShape2D.shape.extents
#	$Objects/player.allowed_movement[0] =  global_position
#	$Objects/player.allowed_movement[1] = global_position + Vector2(extents.x*2, extents.y*2)
 
func _on_area_shape_exited(_area_rid: RID, area: Area2D, _area_shape_index: int, local_shape_index: int) -> void:
	if area:
		var object_exiting = area.get_overlapping_bodies()[local_shape_index]
		if object_exiting is Shape:
			object_exiting.get_node('wrong').play()
			await object_exiting.get_node('wrong') .finished
			object_exiting.queue_free()
#	if len($Objects/shapes.get_children()) == 0 and len(Global.waves) >= Global.wave_number:
#		Global.end_game()

