class_name DebugWindow
extends CanvasLayer

# Exported debug values
@export var num_labels: int = 0
 
var debug_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var vbox_container = VBoxContainer.new()
	vbox_container.add_child(debug_label)
	add_child(vbox_container)
	# Create a new label
	for i in range(num_labels):
		var label = Label.new()
		label.text = "Debug Values:"
		vbox_container.add_child(debug_label)
	
	# Create a VBoxContainer to hold the label
 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update the label text with debug values
	for child in self.get_child(0).get_children():
		child.text =  get_viewport().get_mouse_position() 

# Function to update debug values with mouse position
func displayValues() -> void:
	# Get the mouse position relative to the viewport
	var mouse_position = get_viewport().get_mouse_position()
	# Set the mouse position to debug_value1
	debug_value1 = int(mouse_position.x)
	debug_value2 = float(mouse_position.y)
	debug_value3 = str(mouse_position)

	