extends Node2D


# Called when the node enters the scene tree for the first time.
func trackPlayerPos():
	return str(round($gameField/Objects/player.position.x )) + ' ' + str(round($gameField/Objects/player.position.y ))

func _ready() -> void:
	$Mdebug.track_value('player position',trackPlayerPos  ) 
