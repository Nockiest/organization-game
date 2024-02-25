class_name DebugWindow
extends CanvasLayer

func find_glob_pos():
	return str(get_viewport().get_mouse_position()) 
	
	
 
@onready var vbox_container = $VBoxContainer

@export var debug_label_setter_values: Array = [  find_glob_pos ]
@export var debug_label_setter_labels: Array = [  'mouse.pos' ]
#
#
	
func _ready() -> void:
#	debug_label_setter_values.append(find_glob_pos)
	# Create labels based on the value of num_labels
	for i in debug_label_setter_values :
		var label = Label.new()
		# Set unique names for the labels
		label.name = "DebugLabel_" + str(i)
		label.text = "Debug Values:"
		# Add the label to the VBoxContainer
		vbox_container.add_child(label)

func _process(delta: float) -> void:
 
	# Get the VBoxContainer node
	var vbox_container = $VBoxContainer
	# Update the text of each label with the tracked value
	print( debug_label_setter_values)
	for i in len(debug_label_setter_values) : 
		var fc  = debug_label_setter_values[i]
		var value = fc.call()
		var label_name = "DebugLabel_" + str(i)
		var label = vbox_container.get_child(i)
		label.text = debug_label_setter_labels[i ]+" : " +value
		label.name = label_name
 
func track_value(value_name: String, value ) -> void:
	# Create a new label for the tracked value
	var label = Label.new()
	# Set unique names for the labels
	label.name = "DebugLabel_" #+ str(num_labels)
	# Set the text of the label to display the tracked value
	label.text = value_name + ": "# + str(value)
	# Increment the number of labels
#	num_labels += 1
	# Add the label to the VBoxContainer
	vbox_container.add_child(label)
	debug_label_setter_values.append(value)
	debug_label_setter_labels.append(value_name)
