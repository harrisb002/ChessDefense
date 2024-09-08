extends Node2D

# Signal for piece movement
signal piece_selected(piece) # Pass back the piece itself

#Create References
@onready var icon_path = $Icon # Ref for the path to the piece image

var slot_ID := -1 # Reference the slots ID
var type : int # Type of chess piece (Uses the index to map it in DataHandler)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Load the image based on the piece
func load_icon(piece_name) -> void:
	# Fetches the value from datahandler (The corresponding path for the icons/images)
	icon_path.texture = load(DataHandler.assets[piece_name]) # The piece name is the path to the image


func _on_icon_gui_input(event: InputEvent) -> void:
	# Check if event is a mouse clicked
	if event.is_action_pressed("mouse_left"): # Added in Project Settings -> Input Map
		emit_signal("piece_selected", self) # Pass a ref to the piece object as well 
