class_name Shape extends RigidBody2D

@export var shape_type:= Utils.get_random_enum_value(GameShapes.GameShapeTypes)
 
var shape_color:= Utils.get_random_enum_value(Colors.GameColors,[Colors.GameColors.GRAY] )
 
@export var score:= 50
@export var size:=50
@export var collision_shape: CollisionShape2D
 
 
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
	var earned_score =  round(score/2) if correct_shape else -round(score/2)
	earned_score += round(score/2) if correct_color else 0
	Stats.game_score += earned_score
	queue_free()
func _on_marker_2d_area_entered(area: Area2D) -> void:
	if area is Bucket:
		var bucket = area as Bucket
		if bucket.accepted_shape == shape_type or bucket.shape_color == shape_color:
 
			$correct.play( )
		else:
			$wrong.play( )
		
 
		await  get_tree().create_timer(0.5).timeout 
		$drawShape.shape_color = Colors.GameColors.GRAY
		# Now queue_free the node
#		queue_free()
		
		count_points(bucket.accepted_shape == shape_type , bucket.shape_color == shape_color)
#func _on_marker_2d_area_entered(area: Area2D) -> void:
#
#	if area is Bucket:
#		var bucket = area as Bucket
#		if bucket.accepted_shape == shape_type or bucket.shape_color == shape_color:
#			$correct.play()
#		else:
#			$wrong.play()
#		count_points(bucket.accepted_shape == shape_type , bucket.shape_color == shape_color)


func _on_tree_exiting() -> void:
	if position.y > 1200:
		$wrong.play( )
		await  get_tree().create_timer(2).timeout 
	queue_free()
