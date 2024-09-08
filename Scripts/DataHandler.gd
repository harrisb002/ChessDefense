extends Node

var assets := []

# Make sure that everytime looking for a new piece, 
# 	can get the corresponding location for it

# Create ordered list of Pieces
enum PieceNames { 
	BLACK_BISHOP, 
	WHITE_BISHOP, 
	BLACK_KING, 
	WHITE_KING, 
	BLACK_KNIGHT, 
	WHITE_KNIGHT, 
	BLACK_PAWN, 
	WHITE_PAWN, 
	BLACK_QUEEN, 
	WHITE_QUEEN, 
	BLACK_ROOK, 
	WHITE_ROOK
}

# Dictionary to map fen string notation to the propper icons
# rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR
var fen_dict := {
	"r" = PieceNames.BLACK_ROOK, 
	"n" = PieceNames.BLACK_KNIGHT, 
	"b" = PieceNames.BLACK_BISHOP, 
	"q" = PieceNames.BLACK_QUEEN, 
	"k" = PieceNames.BLACK_KING, 
	"p" = PieceNames.BLACK_PAWN, 
	"R" = PieceNames.WHITE_ROOK, 
	"N" = PieceNames.WHITE_KNIGHT, 
	"B" = PieceNames.WHITE_BISHOP, 
	"Q" = PieceNames.WHITE_QUEEN, 
	"K" = PieceNames.WHITE_KING, 
	"P" = PieceNames.WHITE_PAWN, 
}

# Used for Filter states to show possible movements
enum slot_states{NONE, FREE}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Since I dont have many assets I wont read from directory
	assets.append("res://assets/bishop_b.png")
	assets.append("res://assets/bishop_w.png")
	assets.append("res://assets/king_b.png")
	assets.append("res://assets/king_w.png")
	assets.append("res://assets/knight_b.png")
	assets.append("res://assets/knight_w.png")
	assets.append("res://assets/pawn_b.png")
	assets.append("res://assets/pawn_w.png")
	assets.append("res://assets/queen_b.png")
	assets.append("res://assets/queen_w.png")
	assets.append("res://assets/rook_b.png")
	assets.append("res://assets/rook_w.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
