extends Timer

func _ready() -> void:
	start()
	self.connect("timeout",  Global._on_wave_timeout )
 
