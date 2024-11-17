extends Node2D

# Maze dimensions
var maze_width : int = 21
var maze_height : int = 21

# TileMap and TileMapLayer nodes
var tile_map : TileMap
var tile_map_layer : TileMapLayer

# TileSet with wall and path tiles (ensure this path is correct)
@export var tile_set : TileSet

# Indices for the wall and path tiles in the TileSet
@export var wall_tile : int = 0
@export var path_tile : int = 1

# Maze grid to store wall (0) and path (1) values
var maze_grid : Array

# Directions for maze generation (up, right, down, left)
var directions = [Vector2(1, 0), Vector2(0, 1), Vector2(-1, 0), Vector2(0, -1)]

# Size of each tile (32x32 pixels)
@export var tile_size : Vector2 = Vector2(32, 32)

# Called when the scene is ready
func _ready():
	# Check if tile_set is assigned in the Inspector
	if tile_set == null:
		print("ERROR: TileSet is not assigned!")
		return

	# Create the TileMap node and add it to the scene
	tile_map = TileMap.new()
	add_child(tile_map)

	# Create the TileMapLayer node and add it to the TileMap
	tile_map_layer = TileMapLayer.new()
	tile_map.add_child(tile_map_layer)

	# Set the size of each tile in the TileMap
	tile_map.tile_size = tile_size

	# **Assign the TileSet** to the TileMapLayer via script
	tile_map_layer.tile_set = tile_set

	# Check if the TileSet is correctly assigned to the TileMapLayer
	if tile_map_layer.tile_set == null:
		print("ERROR: TileSet is not assigned to the TileMapLayer!")
		return

	# Initialize the maze grid with all walls (0)
	maze_grid = []
	for y in range(maze_height):
		var row = []
		for x in range(maze_width):
			row.append(0)  # Start with all walls
		maze_grid.append(row)

	# Generate the maze starting from position (1, 1)
	generate_maze(Vector2(1, 1))
	
	# Draw the generated maze in the TileMapLayer
	draw_maze()

# Function to generate the maze using recursive backtracking
func generate_maze(start_pos : Vector2):
	var stack = [start_pos]
	maze_grid[int(start_pos.y)][int(start_pos.x)] = 1  # Mark start position as a path

	while stack.size() > 0:
		var current_pos = stack[stack.size() - 1]
		var directions_shuffled = directions.duplicate()
		directions_shuffled.shuffle()

		var carved = false
		for dir in directions_shuffled:
			var next_pos = current_pos + dir * 2  # Move two steps away from current position

			# Check if the next position is within bounds
			if next_pos.x > 0 and next_pos.y > 0 and next_pos.x < maze_width - 1 and next_pos.y < maze_height - 1:
				if maze_grid[int(next_pos.y)][int(next_pos.x)] == 0:
					# Carve the path
					maze_grid[int(next_pos.y)][int(next_pos.x)] = 1
					maze_grid[int(current_pos.y + dir.y)][int(current_pos.x + dir.x)] = 1
					stack.append(next_pos)
					carved = true
					break

		if not carved:
			stack.remove(stack.size() - 1)

# Function to draw the maze in the TileMapLayer
func draw_maze():
	# Set the size of the grid in the TileMap (this ensures the tilemap covers the entire area)
	tile_map.size = Vector2(maze_width, maze_height)
	
	# Loop through the maze grid and assign tiles to the TileMapLayer
	for y in range(maze_height):
		for x in range(maze_width):
			if maze_grid[y][x] == 0:
				# If it's a wall, use the wall tile
				tile_map_layer.set_cellv(Vector2(x, y), wall_tile)
			else:
				# If it's a path, use the path tile
				tile_map_layer.set_cellv(Vector2(x, y), path_tile)

	# Debug: Print the maze grid to check if it's generated correctly
	print("Maze grid:")
	for row in maze_grid:
		print(row)
