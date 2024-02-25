extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var position = global_position
	var extents =$CollisionShape2D.shape.extents 
	print("Position:", position)
	print("Extents:", extents)
	print('x', [global_position,Vector2(extents.x*2, extents.y*2) ])
	$Objects/player.allowed_movement[0] =  global_position 
	$Objects/player.allowed_movement[1] =  Vector2(extents.x*2, extents.y*2)  
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
