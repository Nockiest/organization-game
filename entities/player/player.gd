class_name Player
extends CharacterBody2D
@export var allowed_movement:Array = [Vector2(-150,0), Vector2(1041,1333)]:
	set(value):
		$MkeyMovement.boundaries= value
		allowed_movement = value
 
var collision_shape: CollisionShape2D

func _draw() -> void:
	draw_circle(Vector2.ZERO, 5 , Color("black"))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get a reference to the CollisionShape2D node
	collision_shape = $CollisionShape2D
	print('allowed ', allowed_movement)
	# Set the boundaries for movement
	$MkeyMovement.boundaries = allowed_movement
	connect("body_entered",  _on_body_entered )
	
#func _on_body_entered(body: Node2D) -> void:
##	print('body collided with player')
#	$thud.play()

#func _on_area_entered(area: Area2D) -> void:
#	print('player collided')

#func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
#	print('player collided with body')
 
func _on_body_entered(body: Node) -> void:
	# Check if the body entered is not the KinematicBody itself
	if body != self:
		# Play the collision sound
		$thud.play()
#func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
##	print('body collided with player')
#	$thud.play()
