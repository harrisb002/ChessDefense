extends Control

# Create References
@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var piece_scene = preload("res://Scenes/piece.tscn")

@onready var chessboard = $ChessBoard
@onready var board_grid = $ChessBoard/BoardGrid

# Create container to save variables
var grid_array := [] # Fetch slot instances 
var piece_array := [] # Fetch piece instances 

var icon_offset := Vector2(25, 25) # Using offset for size of icon/slots
var fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR" # Starting Position Fen String


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
		
		# Init the piece array
		piece_array.resize(64)
		piece_array.fill(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Creates a new slot (Square) for the grid and adds it to the grid_array
func create_slot():
	var new_slot = slot_scene.instantiate() # Instantiate new slot
	new_slot.slot_ID = grid_array.size() # Set the slotID to the current gridSize
	board_grid.add_child(new_slot) # Add the slot to the board grid
	grid_array.push_back(new_slot) # Add a slot instance in the grid array/inc. size


func add_piece(piece_type, location) -> void:
	var new_piece = piece_scene.instantiate() # Create a new piece instance
	chessboard.add_child(new_piece) # Add the piece to the chessboard
	new_piece.type = piece_type # Set the piece type (Path of the piece)
	new_piece.load_icon(piece_type) # Get the piece image
	
	# First find the slots by using the location, location is going to be an index
	# Give it a location based on the grid
	new_piece.global_position = grid_array[location].global_position + icon_offset 
	
	# Set up the attributes
	piece_array[location] = new_piece
	new_piece.slot_ID = location


func _on_test_button_pressed() -> void:
	add_piece(DataHandler.PieceNames.BLACK_KING, 3)


func parse_fen(fen : String) -> void:
	var boardstate = fen.split(" ")
	var board_index := 0
	for i in boardstate[0]: # Getting first portion of string
		if i == "/": continue #Skip dashes
		if i.is_valid_int(): # Check if number
			board_index += i.to_int() # Add based on number of chars in string
		else: 
			# Now seen a letter so add a piece
			add_piece(DataHandler.)
