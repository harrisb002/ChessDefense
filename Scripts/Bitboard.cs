using Godot;
using System;

public partial class Bitboard : Godot.Node
{
	// Seperate each piece into its own bitboard
	// Each ulong represents what current specific piece is on the board
	public ulong[] whitePieces = {0, 0, 0, 0, 0, 0};
	public ulong[] blackPieces = {0, 0, 0, 0, 0, 0};
	
	
	// This is called when the node enters the scene tree for the 1st time
	public override void _Ready() {
	}

	// This is called every frame. 'delta' is the amount of elapsed time since the previous frame.
	public override void _Process(double delta) {
	}

	// Clear the bitboard in case any remaining board exists
	public void ClearBitboard(){
		Array.Clear(whitePieces);
		Array.Clear(blackPieces);
	}

	public void SetBoard(ulong[] Whites, ulong[] Blacks){
		Array.Copy(Whites, whitePieces, Whites.Length);
		Array.Copy(Blacks, blackPieces, Blacks.Length);
	}

	// Propagate pieces based on a FEN string
	public void InitBoard(string fen) {
		ClearBitboard();  // Clear current bitboard state
		string[] fen_split = fen.Split(" ");  
		int row = 0;  // Track the current row 
		int col = 0;  // Track the current column 

		// Process each character in the first part of the FEN string (the board layout)
		foreach (char i in fen_split[0]) {
			if (i.Equals('/')) {
				row++;  // Move to the next row when encountering '/'
				col = 0;  // Reset the column index at the start of each new row
				continue;
			}

			// Check if the character represents an empty space (# of empty spaces present)
			if (Char.IsDigit(i)) {
				int shiftAmount = int.Parse(i.ToString());
				col += shiftAmount;  // Skip columns based on the number provided
				continue;
			}

			// Determine if it's a black or white piece, based on case
			// Then use OR to set corresponding bits 
			if (Char.IsUpper(i)) {
				// Place a white piece at the correct position (row * 8 + col)
				// 1UL represents the number 1 as an unsigned long integer (64-bit).
				whitePieces[DataHandlerCS.FenDict[Char.ToLower(i)]] |= 1UL << (row * 8 + col);
			} else {
				// Place a black piece at the correct position (row * 8 + col)
				blackPieces[DataHandlerCS.FenDict[i]] |= 1UL << (row * 8 + col);
			}

			col++;  // Move to the next column
		}
		GD.Print("Bitboard init done");
	}

	public ulong GetBitboard(){
		return blackPieces[0];
	}

	// Return the selected colors bitboard by combining all pieces and returning
	public ulong GetBlackBoard(){
		ulong pieces = 0;
		foreach(ulong piece in blackPieces) {
			pieces |= piece;
		}
		return pieces;
	}
	public ulong GetWhiteBoard(){
		ulong pieces = 0;
		foreach(ulong piece in whitePieces) {
			pieces |= piece;
		}
		return pieces;
	}


	// public void TestFunction() {
	// 	GD.Print("TestFunction is being called from the C# code!");
	// }
}
