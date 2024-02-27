class_name Shape extends RigidBody2D

@export var shape_type:= Utils.get_random_enum_value(GameShapes.GameShapeTypes):
	set(value):
		shape_type=value
		update_collision_shape()
@export var shape_color:= Utils.get_random_enum_value(Colors.GameColors):
	set(value):
		shape_color=value
		update_collision_shape()
@export var score:= 50
@export var size:=50
@export var collision_shape: CollisionShape2D:
	set(value):
		collision_shape=value
		update_collision_shape()
var velocity = Vector2(0,1)


func _draw() -> void:
	update_collision_shape()

 

func update_collision_shape() -> void:
	if not collision_shape:
		return
	match shape_type:
		GameShapes.GameShapeTypes.RECTANGLE:
			collision_shape.shape = RectangleShape2D.new()
			collision_shape.shape.extents = Vector2(size, size)
		GameShapes.GameShapeTypes.TRIANGLE:
			collision_shape.shape = ConvexPolygonShape2D.new()
			var polygon = PackedVector2Array()
			polygon.push_back(Vector2(0, -size))
			polygon.push_back(Vector2(size, size))
			polygon.push_back(Vector2(-size, size))
			collision_shape.shape.set_points(polygon)
		GameShapes.GameShapeTypes.CIRCLE:
			# Set collision shape to circle
			collision_shape.shape = CircleShape2D.new()
			collision_shape.shape.radius = size
		_:
			assert(false, 'invalid set shape type')

 
func count_points(correct_shape:bool,correct_color:bool):
	var earned_score =  score/2 if correct_shape else -(score/2)
	earned_score += score/2 if correct_color else 0
	Stats.game_score += earned_score
	queue_free()

func _on_marker_2d_area_entered(area: Area2D) -> void:
#	print('marker entered ', area)
	if area is Bucket:
		var bucket = area as Bucket
#		print('marker entered a bucket')
#		print('marker entered a bucket ' ,bucket.accepted_shape, shape_type)
		count_points(bucket.accepted_shape == shape_type , bucket.shape_color == shape_color)
