extends Node
 
func are_points_far_enough(a:Vector2, b:Vector2, min_distance:int):
	return a.distance_to(b) > min_distance
	
func find_child_with_variable(parent, variable):
	for child in parent.get_children():
		if variable in child:
			return child
	return null
	
func square_to_packed_polygon(col_shape: CollisionShape2D) -> Polygon2D:
	var size = col_shape.shape.extents * 2
	var half_size = size / 2
	var position = col_shape.global_position

	var polygon = Polygon2D.new()
	polygon.set_polygon(PackedVector2Array(
		[
		Vector2(position.x - half_size.x, position.y - half_size.y),
		Vector2(position.x + half_size.x, position.y - half_size.y),
		Vector2(position.x + half_size.x, position.y + half_size.y),
		Vector2(position.x - half_size.x, position.y + half_size.y)
		]
		))
 
	return polygon
 
 
## you have to put this variable wheter you want to put the z_indexes
var nodes_list = []
func get_z_indexes(node,nodes_list_arg):
	if node is CanvasItem:
		nodes_list_arg.append([node, node.z_index])
	for child in node.get_children():
		get_z_indexes(child,nodes_list_arg)
func sort_by_z_index_desc(a, b):
	return a[1] < b[1]
	
func convert_to_normal_vector(Vector:Vector2i) -> Vector2:
	var normal_vector: Vector2= Vector
	return normal_vector 
 
func get_collision_shape_center(area: Area2D, node_name: String= "CollisionShape2D") -> Vector2:
	if area.get_node(node_name) == null:
		print("AREA doesnt haVE A COLLISION SHAPE 2D")
		return Vector2.ZERO 
	var shape = area.get_node(node_name).shape 
	if shape is RectangleShape2D:
		var rect_shape =  shape   as RectangleShape2D
		return area.global_position  + Vector2(rect_shape.extents.x, rect_shape.extents.y)
	elif  shape is CircleShape2D:
#		var circle_shape =  shape #as CircleShape2D
		return  area.global_position 
	else:
		assert (false, "Unsupported collision shape type")
		return Vector2.ZERO
 
func play_animation_at_position(animation_node, animation  , position: Vector2, z_index=4096) -> void:
	if animation_node == null:
		print("No animation found with name: ", animation_node)
		return
	animation_node.z_index = z_index
	animation_node.show()
	# Set the position of the animation
	animation_node.global_position = position
	animation_node.play(animation)
	print("playing animation",animation_node, animation  , position)
	# Hide the animation after it finishes playing
	await animation_node.animation_finished 
	animation_node.hide()

func get_random_point_in_square(square_size: Vector2) -> Vector2: ## shape extents only return half the size of the collision shape
	var random_x = randi_range(0, int(square_size.x))
	var random_y = randi_range(0, int(square_size.y))
#	print(Vector2(random_x, random_y),square_size.x," ",square_size.y)
	return Vector2(random_x, random_y)

## doesnt work how I intended
func lighten_color(color: Color, points: int) -> Color:
	# Convert the color to RGB format
	var r = int(color.r * 255)
	var g = int(color.g * 255)
	var b = int(color.b * 255)

	# Subtract the specified number of points from each color component
	r = max(0, r - points)
	g = max(0, g - points)
	b = max(0, b - points)

	# Convert the lightened color back to Color format
	return Color(r / 255.0, g / 255.0, b / 255.0)
 
## doesnt work
func area_to_line2d(area: Area2D, width: float) -> Line2D:
	var line = Line2D.new()
	line.width = width
	for shape in area.get_shapes():
		if shape is CollisionPolygon2D:
			var points = shape.shape.get_points()
			for i in range(points.size()):
				line.add_point(points[i])
	return line

## tested
func polygon_to_line2d(polygon: Polygon2D, width: float, color: Color = Color(1, 1, 1, 1)) -> Line2D:
	var line = Line2D.new()
	var vertecies = polygon.get_polygon()
	vertecies.append(vertecies[0]) ## so the line is circumnavigating the whole polygon
#	print(vertecies)
	line.width = width
	line.modulate = color
	for i in range( len(vertecies) ):
		line.add_point(vertecies[i])
	return line
	
func sum_dict_values(dict: Dictionary) -> float:
	var sum = 0.0
	for value in dict.values():
		if typeof(value) == TYPE_INT || typeof(value) == TYPE_FLOAT:
			sum += value
		else:
			assert(false, "DICTIONARY ISNT COMPLETELY MADE OF NUMBERS")
	return sum
	
func orientation(p, q, r):
		var val = (q[1] - p[1]) * (r[0] - q[0]) - (q[0] - p[0]) * (r[1] - q[1])
		if val == 0:
			return 0
		return 1 if val > 0 else 2

func do_lines_intersect(p1, p2, p3, p4):
	var o1 = orientation(p1, p2, p3)
	var o2 = orientation(p1, p2, p4)
	var o3 = orientation(p3, p4, p1)
	var o4 = orientation(p3, p4, p2)

	if o1 != o2 and o3 != o4:
		if min(p1[0], p2[0]) <= max(p3[0], p4[0]) and min(p3[0], p4[0]) <= max(p1[0], p2[0]) and \
			min(p1[1], p2[1]) <= max(p3[1], p4[1]) and min(p3[1], p4[1]) <= max(p1[1], p2[1]):
			# Calculate the point of intersection
			var intersect_x = (o1 * p3[0] - o2 * p4[0]) / (o1 - o2)
			var intersect_y = (o1 * p3[1] - o2 * p4[1]) / (o1 - o2)
			return Vector2(intersect_x, intersect_y)

	return Vector2.ZERO
 
func do_lines_intersect_in_viewport(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2) -> Vector2:
	var o1 = orientation(p1, p2, p3)
	var o2 = orientation(p1, p2, p4)
	var o3 = orientation(p3, p4, p1)
	var o4 = orientation(p3, p4, p2)

	if o1 != o2 and o3 != o4:
		if min(p1.x, p2.x) <= max(p3.x, p4.x) and min(p3.x, p4.x) <= max(p1.x, p2.x) and \
			min(p1.y, p2.y) <= max(p3.y, p4.y) and min(p3.y, p4.y) <= max(p1.y, p2.y):
			# Calculate the point of intersection
			var intersect_x = (o1 * p3.x - o2 * p4.x) / (o1 - o2)
			var intersect_y = (o1 * p3.y - o2 * p4.y) / (o1 - o2)
			var intersection_point = Vector2(intersect_x, intersect_y)

			# Check if the intersection point is inside the viewport
			if intersection_point.x >= 0 and intersection_point.x <= get_viewport().size.x and \
			   intersection_point.y >= 0 and intersection_point.y <= get_viewport().size.y:
				return intersection_point

	return Vector2.ZERO

func print_spaced(messages: Array, debug:bool=true) -> void:
	var formatted_message: String = ""
	for i in range(messages.size()):
		formatted_message += str(messages[i])
		if i < messages.size() - 1:
			formatted_message += "; "
	if debug:
		print_debug(formatted_message)
	else:
		print(formatted_message)

 
func calculate_is_inside(polygon, point = Vector2(100,100)):
#	print(collision_shape.polygon)
#	var point_in_local = polygon.to_local(point ) #.get_global_transform()
	var vertecies =polygon.get_polygon()
	var global_vertecies = []
	for v in vertecies:
		global_vertecies.append(polygon.to_global(v))   
	return Geometry2D.is_point_in_polygon(point,global_vertecies)

func generate_bezier_curve(start:Vector2, end:Vector2, control_point:Vector2,  num_segments:int):
	var t:float = 0
	var points = []
	var segments = []
	while t <= 1:
		# Define the control points for the Bézier curve 
		var q0 = start.lerp(control_point, t)
		var q1 = control_point.lerp(end , t)
		var point = q0.lerp(q1, t)
		# Generate two random points between the start and end points
		points.append(point)
#		print(line.points.size)
		if len( points) >= 2:
			segments.append([ round(points[-1]), round(points[-2]) ])
		t += 1.0/num_segments
	return segments
	
func find_ancestor_by_factor(x: int, node: Node) -> Node:
	var current_node = node

	# Iterate x times to find the ancestor
	for i in range(x):
		# Check if the current node has a parent
		if current_node.get_parent() != null:
			current_node = current_node.get_parent()
		else:
			# If no parent, break out of the loop
			break

	return current_node
# sadly not working
#func find_ancestor_by_class(name_of_class: String, node: Node) -> Node:
#	var current_node = node
#
#	# Check if the current node has the specified class name
#	if current_node.get_class() == name_of_class:
#		return current_node
#
#	# If not, recursively check the parent's ancestors
#	if current_node.get_parent() != null:
#		return find_ancestor_by_class(name_of_class, current_node.get_parent())
#
#	# If no parent or matching class name found, return null
#	return null
