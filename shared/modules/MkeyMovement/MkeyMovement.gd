extends Node

@export var MovedObject: Node2D
@export var speed: float = 100
@export var rotation_speed: float = 1.0  # Adjust the rotation speed as needed

# Define the boundaries array with the screen size
@export var boundaries: Array = [Vector2(0, 0), Vector2(1000, 1000)]

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
	
	# Check if the new position exceeds the boundaries using collision detection
#	var collision = MovedObject.move_and_collide(motion)
#	if collision:
#		# If there is a collision, adjust the motion accordingly
#		var collision_normal = collision.normal
#		motion = motion.slide(collision_normal)
	
	# Rotate the parent node around its center based on button presses
	if Input.is_action_pressed("rotate_clockwise"):
		MovedObject.rotate(-rotation_speed * delta)
	if Input.is_action_pressed("rotate_counterclockwise"):
		MovedObject.rotate(rotation_speed * delta)
