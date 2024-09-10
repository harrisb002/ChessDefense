using Godot;
using System;

public class Rook : Piece
{
	public Rook(int position, ulong selfBoard, ulong enemyBoard, bool isBlack)
		: base(position, selfBoard, enemyBoard, isBlack)
	{
	}

	public override ulong GeneratePath()
	{
		ulong legalMoves = 0;
		
		// Calculate moves in all directions for the rook
		legalMoves |= GetDirection(1, 0);   // Right
		legalMoves |= GetDirection(-1, 0);  // Left
		legalMoves |= GetDirection(0, 1);   // Up
		legalMoves |= GetDirection(0, -1);  // Down
		
		return legalMoves;
	}

	private ulong GetDirection(int xIncrement, int yIncrement)
	{
		ulong legalMoves = 0;
		int currentX = Position % 8;  // Get current column
		int currentY = Position / 8;  // Get current row
		int steps = 1;

		// Loop until rook
		// - finds edge of the board.
		// - finds enemy piece (which captures).
		// - finds one of its own pieces (which blocks).
		while (true)
		{
			int newX = currentX + xIncrement * steps; // Horz movement
			int newY = currentY + yIncrement * steps; // Vert movement
			int newPosition = newY * 8 + newX; // Use bitboard calc.

			// Make sure its within the bounds of the board
			if (newX < 0 || newX >= 8 || newY < 0 || newY >= 8 || newPosition < 0 || newPosition >= 64)
				break;

			// Check for enemy pieces
			if ((EnemyBoard & (1UL << newPosition)) != 0)
			{
				legalMoves |= 1UL << newPosition;  // Adds pos. to legalMoves bitboard by setting corresponding bit to 1
				break; // Stop after capture
			}

			// Check for self pieces
			// SelfBoard represents all the positions occupied by the player's own pieces.
			if ((SelfBoard & (1UL << newPosition)) != 0) // check for a piece of the same side occupying the square 
			{
				// rResult will be # where only bits that are 1 in both the SelfBoard and the bitmask will be 1; all other bits will be 0.
				break;  // Blocked by own piece
			}

			// Mark the position as a legal move
			legalMoves |= 1UL << newPosition;
			steps++;
		}

		return legalMoves;
	}
}
