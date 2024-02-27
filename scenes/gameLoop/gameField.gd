class_name GameField
extends Area2D

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
