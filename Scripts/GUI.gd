extends Control

# Create References
@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var board_grid = $ChessBoard/BoardGrid


# Create container to save variables (Fetch slot instances through this)
var grid_array := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(64):
		create_slot()
		
	# Set color background based on even/odd to flip clorbit
	var colorbit := 0
	for i in range(8):
		for j in range(8):
			if j%2 == colorbit:
				grid_array[i*8+j].set_background(Color.CADET_BLUE)
		if colorbit == 0: # Flip bit cause each starting row is dif.
			colorbit = 1
		else: colorbit = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func create_slot():
	# Instantiate new slot
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	board_grid.add_child(new_slot)
	grid_array.push_back(new_slot)
