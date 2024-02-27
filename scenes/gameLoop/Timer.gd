extends Timer

func _ready() -> void:
	start()

func get_remaining_time() -> String:
	return  str(round(time_left))
