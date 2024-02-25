class_name KeyMovement
extends Node

@export var MovedObject: Node2D
@export var speed: float = 100
@export var rotation_speed: float = 1.0  # Adjust the rotation speed as needed

# Define the boundaries array with the screen size
@export var boundaries: Array = [Vector2(0, 0), Vector2(1000, 1000)]
@onready var prev_position = MovedObject.position 

func _process(delta: float) -> void:
	# Get the input vector based on WASD keys
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	
	# Normalize the input vector to ensure consistent speed in all directions
	input_vector = input_vector.normalized()
	
	# Move the parent node based on input
	var motion = input_vector * speed * delta
	
	# Calculate the new position
	var new_position = MovedObject.global_position + motion
#	print(clamp(boundaries[0][0], new_position.x, boundaries[1][0]),clamp(boundaries[0][1], new_position.y, boundaries[1][1]))
	MovedObject.position  = Vector2(clamp(boundaries[0][0], new_position.x, boundaries[1][0]),clamp(boundaries[0][1], new_position.y, boundaries[1][1]))
	
	if Input.is_action_pressed("rotate_clockwise"):
		MovedObject.rotation_degrees -= rotation_speed * delta
	if Input.is_action_pressed("rotate_counterclockwise"):
		MovedObject.rotation_degrees += rotation_speed * delta
	prev_position = MovedObject.position 
#	if Input.is_action_pressed("rotate_clockwise"):
#		MovedObject.rotate(-rotation_speed * delta)
#	if Input.is_action_pressed("rotate_counterclockwise"):
#		MovedObject.rotate(rotation_speed * delta)
 
