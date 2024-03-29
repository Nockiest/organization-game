class_name ShapeDrawer
extends Node2D

@export var parent: Node
@export var shape_type:= GameShapes.GameShapeTypes.RECTANGLE:
	set(value):
		shape_type = value
		queue_redraw()
@export var shape_color:= Colors.GameColors.BLUE:
	set(value):
		shape_color = value
		queue_redraw()
		
@export var size:=50 
var colors_instance = Colors.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if parent:
		if 'shape_type' in parent:
			shape_type = parent.shape_type

		shape_color = parent.shape_color
		if 'size' in parent:
				size = parent.size

		global_position = parent.global_position
	else:
		assert(false, 'parent not set')


func _draw() -> void:
	var draw_color = colors_instance.translate_val_to_color(shape_color)
#	print(draw_color, 'draw_color')
	match shape_type:
		GameShapes.GameShapeTypes.RECTANGLE:
			draw_rect(Rect2(-size, -size, size * 2, size * 2), draw_color)
		GameShapes.GameShapeTypes.TRIANGLE:
			var color_array = [draw_color, draw_color, draw_color]
			draw_polygon([Vector2(0, -size), Vector2(size, size), Vector2(-size, size)], color_array)
		GameShapes.GameShapeTypes.CIRCLE:
			draw_circle(Vector2.ZERO, size, draw_color)
		_:
			assert(false, "Invalid game shape type set "   )
