class_name Shape extends RigidBody2D

@export var shape_type:= GameShapes.RECTANGLE:
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
#func _ready() -> void:
#	update_collision_shape()

func _draw() -> void:
	update_collision_shape()

 

func update_collision_shape() -> void:
	match shape_type:
		GameShapes.RECTANGLE:
			# Set collision shape to rectangle
			collision_shape.shape = RectangleShape2D.new()
			collision_shape.shape.extents = Vector2(size, size)
		GameShapes.TRIANGLE:
			# Set collision shape to convex polygon
			collision_shape.shape = ConvexPolygonShape2D.new()
			var polygon = PackedVector2Array()
			polygon.push_back(Vector2(0, -size))
			polygon.push_back(Vector2(size, size))
			polygon.push_back(Vector2(-size, size))
			collision_shape.shape.set_points(polygon)
		GameShapes.CIRCLE:
			# Set collision shape to circle
			collision_shape.shape = CircleShape2D.new()
			collision_shape.shape.radius = size


func _on_body_entered(body: Node) -> void:
	print('body entered')


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print('body shape entered',body)


func _on_sleeping_state_changed() -> void:
	print('sleeping changed')

#func _physics_process(delta: float) -> void:
#	var collision_info = move_and_collide(velocity*delta)
#	if collision_info:
#		print(collision_info)
#		velocity = velocity.bounce(collision_info.normal)
#	if Input.is_action_just_pressed( "ui_accept"):
#		apply_central_impulse(Vector2(1,1))
