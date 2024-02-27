class_name Bucket
extends Area2D


@export var accepted_shape: GameShapes.GameShapeTypes = GameShapes.GameShapeTypes.CIRCLE
#var shape_type =  accepted_shape
@export var shape_color := Colors.GameColors.BLUE

func _ready():
#	print('shape type',shape_type)
	$drawShape.shape_type =  accepted_shape
