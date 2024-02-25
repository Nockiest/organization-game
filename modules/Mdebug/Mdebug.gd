class_name DebugWindow
extends CanvasLayer

# Exported debug values
@export var num_labels: int = 1
@onready var vbox_container = $VBoxContainer
func _ready() -> void:
 
	# Create labels based on the value of num_labels
	for i in range(num_labels):
		var label = Label.new()
		# Set unique names for the labels
		label.name = "DebugLabel_" + str(i)
		label.text = "Debug Values:"
		# Add the label to the VBoxContainer
		vbox_container.add_child(label)

func _process(delta: float) -> void:
	# Update the text of each label with mouse position
	for i in range(num_labels):
		var label_name = "DebugLabel_" + str(i)
		var label = $VBoxContainer.get_node(label_name)
		if label:
			label.text = "Mouse Position: " + str(get_viewport().get_mouse_position())
func track_value(value_name: String, value: Variant) -> void:
	# Create a new label for the tracked value
	var label = Label.new()
	# Set unique names for the labels
	label.name = "DebugLabel_" + str(num_labels)
	# Set the text of the label to display the tracked value
	label.text = value_name + ": " + str(value)
	# Increment the number of labels
	num_labels += 1
	# Add the label to the VBoxContainer
	vbox_container.add_child(label)
