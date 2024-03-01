# save_load.gd
 
extends Node
 
const SAVEFILE:String = "user://savefile.save"
 
var highest_record:int = 0
 
func _ready():
	load_score()
#	Global.high_score = str(  highest_record )
func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE_READ)
	file.store_32(Global.high_score)
	file = null
 
func load_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if FileAccess.file_exists(SAVEFILE):
		Global.high_score = file.get_32()
	file = null
 
# main.gd
# i skipped some less important stuff
 
 
#func on_save_score_pressed():
#	if ( current_score > SaveLoad.highest_record ):
#		SaveLoad.highest_record = current_score
#		highest_label.text = str( current_score )
#	SaveLoad.save_score()
