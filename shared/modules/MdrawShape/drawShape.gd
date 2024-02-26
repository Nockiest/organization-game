extends Node2D

@export var parent: Node
@export var shape_type:= GameShapes.RECTANGLE
@export var shape_color:= Colors.GameColors.BLUE
@export var score:= 50
@export var size:=50
@export var collision_shape: CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _process(_delta) -> void:
	if parent:
		shape_type = parent.shape_type
		shape_color = parent.shape_color
		score = parent.score
		size = parent.size
		collision_shape = parent.collision_shape
		global_position = parent.global_position
	else:
		assert(false, 'parent not set')

func _draw() -> void:
	var draw_color = Utils.translate_val_to_color(shape_color)
 
	match shape_type:
		GameShapes.RECTANGLE:
			draw_rect(Rect2(-size, -size, size * 2, size * 2), draw_color)
		GameShapes.TRIANGLE:
			var color_array = [draw_color, draw_color, draw_color]
			draw_polygon([Vector2(0, -size), Vector2(size, size), Vector2(-size, size)], color_array)
		GameShapes.CIRCLE:
			draw_circle(Vector2.ZERO, size, draw_color)
