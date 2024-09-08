extends Node2D

#Create References
@onready var icon_path = $Icon # Ref for the path to the piece image

# Reference the slots ID
var slot_ID := -1

# Type of chess piece
var type : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Load the image based on the piece
func load_icon(piece_name) -> void:
	# Fetches the value from datahandler (The corresponding path for the icons/images)
	icon_path.texture = load(DataHandler.assets[piece_name]) # The piece name is the path to the image
