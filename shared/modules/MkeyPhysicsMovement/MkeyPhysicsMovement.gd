extends Node

@export var MovedObject: RigidBody2D 
@export var max_speed: float = 100
@export var push_speed: float = 100
@export var rotation_speed: float = 1.0  # Adjust the rotation speed as needed

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var motion = Vector2.ZERO
		var strength = push_speed * get_push_strength(event) * get_push_direction(event)

		MovedObject.apply_central_impulse(strength)
		
		# Limit speed to max_speed
#		MovedObject.linear_velocity = MovedObject.linear_velocity.clamped(max_speed)

func get_push_strength(event: InputEventKey) -> float:
	if event.is_pressed():
		return 1
	else:
		return 0

func get_push_direction(event: InputEventKey) -> Vector2:
	if event.scancode == KEY_W:
		return Vector2(0, -1)
	elif event.scancode == KEY_S:
		return Vector2(0, 1)
	elif event.scancode == KEY_A:
		return Vector2(-1, 0)
	elif event.scancode == KEY_D:
		return Vector2(1, 0)
	else:
		return Vector2.ZERO
