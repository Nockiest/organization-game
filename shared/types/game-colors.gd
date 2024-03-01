class_name Colors
extends Node


# Called when the node enters the scene tree for the first time.

#var red = Color('red')
#var blue = Color('blue')
#var green = Color('green')
var YELLOW = Color('#C8F024')
var BLUE = Color('#2B39F0')
var RED = Color('#F0662C')
var GREEN = Color('#59F00E')
var GRAY = Color('gray')
enum GameColors {
	RED   ,
	BLUE  ,
	GREEN  ,
	GRAY,
#	YELLOW
}

 
func translate_val_to_color(color: Colors.GameColors) -> Color  :
	match color:
		Colors.GameColors.RED:
			return RED # Assuming RED is predefined
		Colors.GameColors.BLUE:
			return BLUE # Assuming BLUE is predefined
		Colors.GameColors.GREEN:
			return GREEN # Assuming GREEN is predefined
		Colors.GameColors.GRAY:
			return GRAY # Assuming GREEN is predefined
#		Colors.GameColors.YELLOW:
#			return Color(1, 1, 0) # Assuming YELLOW is predefined
		_:
			assert(false,"Color not found")
			return Color(0, 0, 0)
