extends Control

# Create References
@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var piece_scene = preload("res://Scenes/piece.tscn")

@onready var chessboard = $ChessBoard
@onready var board_grid = $ChessBoard/BoardGrid

# CSharp code refs
@onready var bitboard = $Bitboard


# Create container to save variables
var grid_array := [] # Fetch slot instances 
var piece_array := [] # Fetch piece instances 

var icon_offset := Vector2(25, 25) # Using offset for size of icon/slots
var fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR" # Starting Position Fen String

# Piece Movement
var piece_selected = null;

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
func _process(_delta: float) -> void:
	pass

# Creates a new slot (Square) for the grid and adds it to the grid_array
func create_slot():
	var new_slot = slot_scene.instantiate() # Instantiate new slot
	new_slot.slot_ID = grid_array.size() # Set the slotID to the current gridSize
	board_grid.add_child(new_slot) # Add the slot to the board grid
	grid_array.push_back(new_slot) # Add a slot instance in the grid array/inc. size
	
	# Utilize the slot clicked signal by connecting the slot signal
	new_slot.slot_clicked.connect(_on_slot_clicked)


# Move the piece based on the slot clicked on (If a piece is selected)
func _on_slot_clicked(slot) -> void:
	if not piece_selected:
		return # Dont do anything if piece not selected
	move_piece(piece_selected, slot.slot_ID) # move a piece if selected 
	piece_selected = null # After piece has been moved, then set it back to null


# Move the selected piece to the slot clicked on
func move_piece(piece, location) -> void:
	# Capture Logic
	if piece_array[location]: # If piece resides at the location
		if piece_array[location] == piece:
			return
		piece_array[location].queue_free() # Remove the piece at the new location 
		piece_array[location] = 0
	
	# Set the new location using tween
	var tween = get_tree().create_tween()
	tween.tween_property(piece, "global_position", grid_array[location].global_position + icon_offset, 0.2)
	piece_array[piece.slot_ID] = 0 # delete the piece from its original position 
	piece_array[location] = piece # Add it to the new location	
	piece.slot_ID = location # Update the slotID

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
	
	# Add a connection using the name of the signal passed by the piece
	new_piece.piece_selected.connect(_on_piece_selected)


func _on_piece_selected(piece):
	if not piece_selected:
		piece_selected = piece # Set it to the passed piece from the emitted signal
	else:
		# I clicking on a piece that is not the piece currently selected, then direct it into the slot clicked
		# This is for captures
		_on_slot_clicked(grid_array[piece.slot_ID])
		


# Use a bitboard (0-63 bits) to map the color of the filter 
func set_board_filter(bitmap : int):
	for i in range(64):
		if bitmap & 1: # If current bit is a 1
			# Reversing the location index of the peices of the board based on how the c# code is written 
			grid_array[i].set_filter(DataHandler.slot_states.FREE)
		bitmap = bitmap >> 1 # Shift right


func _on_test_button_pressed() -> void:
	# add_piece(DataHandler.PieceNames.BLACK_KING, 3)
	# set_board_filter(1023)
	
	# Testing Bitboard 
	bitboard.call("InitBoard", fen)
	set_board_filter(bitboard.call("GetBitboard"))
	parse_fen(fen) # Create starting board


func parse_fen(fen : String) -> void:
	var boardstate = fen.split(" ")
	var board_index := 0
	for i in boardstate[0]: # Getting first portion of string
		if i == "/": continue # Skip dashes
		if i.is_valid_int(): # Check if number
			board_index += i.to_int() # Add based on number of chars in string
		else: 
			# Now seen a letter so add a piece, add based on pieceType
			add_piece(DataHandler.fen_dict[i], board_index)
			board_index += 1
