class_name Shape extends RigidBody2D

@export var shape_type:= GameShapes.GameShapeTypes.RECTANGLE:
	set(value):
		shape_type=value
		update_collision_shape()
@export var shape_color:= Colors.GameColors.BLUE:
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

#func _on_body_entered(body: Node) -> void:
#	print('body entered')
#
#
#func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
#	print('body shape entered',body)
#
#
#func _on_sleeping_state_changed() -> void:
#	print('sleeping changed')

#func _physics_process(delta: float) -> void:
#	var collision_info = move_and_collide(velocity*delta)
#	if collision_info:
#		print(collision_info)
#		velocity = velocity.bounce(collision_info.normal)
#	if Input.is_action_just_pressed( "ui_accept"):
#		apply_central_impulse(Vector2(1,1))
func count_points(correctly_sorted:bool):
	Stats.game_score += score if correctly_sorted else -score 
	queue_free()

func _on_marker_2d_area_entered(area: Area2D) -> void:
#	print('marker entered ', area)
	if area is Bucket:
		var bucket = area as Bucket
#		print('marker entered a bucket')
		print('marker entered a bucket ' ,bucket.accepted_shape, shape_type)
		count_points(bucket.accepted_shape == shape_type and bucket.shape_color == shape_color)
