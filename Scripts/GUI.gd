extends Control

# Create References
@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var board_grid = $ChessBoard/BoardGrid


# Create container to save variables (Fetch slot instances through this)
var grid_array := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func create_slots():
	# Instantiate new slot
	var new_slot = slot_scene.instantiate()
	new_slot.slot_ID = grid_array.size()
	grid_array.push_back(new_slot)
