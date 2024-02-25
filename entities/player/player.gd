extends Node2D
@export var allowed_movement:Array = [Vector2(0,0), Vector2(200,200)]:
	set(value):
		$MkeyMovement.boundaries= value
		return value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MkeyMovement.boundaries= allowed_movement


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
