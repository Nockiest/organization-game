class_name ShapeDrawer
extends Node2D

@export var parent: Node
@export var shape_type:= GameShapes.GameShapeTypes.RECTANGLE
@export var shape_color:= Colors.GameColors.BLUE
@export var size:=50
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if parent:
#		if 'shape_type' in parent :
#	print()
		shape_type = parent.shape_type
#		if 'shape_color' in parent :
		shape_color = parent.shape_color
#		if 'size' in parent :
		size = parent.size
#		if 'collision_shape' in parent :
#			collision_shape = parent.collision_shape
		
#		shape_type = parent.shape_type
#		shape_color = parent.shape_color
#		score = parent.score
#		size = parent.size
#		collision_shape = parent.collision_shape
		global_position = parent.global_position
	else:
		assert(false, 'parent not set')
func _process(_delta) -> void:
	if parent:
#		if 'shape_type' in parent :
#	print()
		shape_type = parent.shape_type
#		if 'shape_color' in parent :
		shape_color = parent.shape_color
#		if 'size' in parent :
		size = parent.size
#		if 'collision_shape' in parent :
#			collision_shape = parent.collision_shape
		
#		shape_type = parent.shape_type
#		shape_color = parent.shape_color
#		score = parent.score
#		size = parent.size
#		collision_shape = parent.collision_shape
		global_position = parent.global_position
	else:
		assert(false, 'parent not set')

func _draw() -> void:
	var draw_color = Utils.translate_val_to_color(shape_color)
	print(shape_type, GameShapes.GameShapeTypes, GameShapes.GameShapeTypes.RECTANGLE, GameShapes.GameShapeTypes.CIRCLE, GameShapes.GameShapeTypes.TRIANGLE)
	match shape_type:
		GameShapes.GameShapeTypes.RECTANGLE:
			print(1)
			draw_rect(Rect2(-size, -size, size * 2, size * 2), draw_color)
		GameShapes.GameShapeTypes.CIRCLE:
			print(2)
			var color_array = [draw_color, draw_color, draw_color]
			draw_polygon([Vector2(0, -size), Vector2(size, size), Vector2(-size, size)], color_array)
		GameShapes.GameShapeTypes.TRIANGLE:
			print(3)
			draw_circle(Vector2.ZERO, size, draw_color)
		_:
			assert(false, "Invalid game shape type set "   )
		
