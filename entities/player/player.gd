extends Node2D
@export var allowed_movement:Array = [Vector2(0,0), Vector2(200,200)]:
	set(value):
		$MkeyMovement.boundaries= value
		return value

# Reference to the CollisionShape2D node
var collision_shape: CollisionShape2D

func _draw() -> void:
	# Set the Z-index for the drawing
 

	# Draw the stuff here
	draw_circle(Vector2.ZERO, 5 , Color("black"))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get a reference to the CollisionShape2D node
	collision_shape = $CollisionShape2D

	# Set the boundaries for movement
	$MkeyMovement.boundaries = allowed_movement

	# Adjust the draw shape to match the collision shape
#	update_draw_shape()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#
#func _on_area_entered(area: Area2D) -> void:
#	print('player collided')
#
#
#func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
#	print('player collided with shape')
#
#
#func _on_body_entered(body: Node2D) -> void:
#	print('body collided with player')
#
#
#func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
#	print('body entered with player')
