extends Node

@export var MovedObject: Node2D
 
@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	print('moving')
	# Move the parent node based on input
	var motion = input_vector * speed * delta
	# Translate the parent node's position
	MovedObject.translate(motion)
