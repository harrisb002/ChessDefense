using Godot;
using System;

public abstract class Piece
{
	public int Position { get; set; }
	public ulong SelfBoard { get; set; }
	public ulong EnemyBoard { get; set; }
	public bool IsBlack { get; set; }

	public Piece(int position, ulong selfBoard, ulong enemyBoard, bool isBlack)
	{
		Position = position;
		SelfBoard = selfBoard;
		EnemyBoard = enemyBoard;
		IsBlack = isBlack;
	}

	// Abstract method to be implemented by specific piece types to calculate legal moves
	public abstract ulong GeneratePath();
}
