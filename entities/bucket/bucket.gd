class_name Bucket
extends Area2D


@export var accepted_shape: GameShapes.GameShapeTypes = GameShapes.GameShapeTypes.CIRCLE
var shape_type =  accepted_shape
@export var shape_color := Colors.GameColors.BLUE

# these values are for the draw shape function 
var size = 50
@export var collision_shape: CollisionShape2D  
#@export var global_position = parent.global_position
 


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
