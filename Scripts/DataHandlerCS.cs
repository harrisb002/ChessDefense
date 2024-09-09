using Godot;
using System;
using System.Collections.Generic;

public partial class DataHandlerCS : Node
{
	// Represent the order in the bitboard
	public enum PieceNames { ROOK, KNIGHT, BISHOP, QUEEN, KING, PAWN }

	// Match the characters with its corresponding pieces for the Enum
	public static Dictionary<char, int> FenDict = new Dictionary<char, int>() {
		{'r', 0},{'n', 1},{'b', 2},{'q', 3},{'k', 4},{'p', 5}
	};

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
