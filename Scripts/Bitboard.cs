using Godot;
using System;

public partial class Bitboard : Godot.Node
{
	// This is called when the node enters the scene tree for the 1st time
	public override void _Ready() {
	}

	// This is called every frame. 'delta' is the amount of elapsed time since the previous frame.
	public override void _Process(double delta) {
	}

	public void TestFunction() {
		GD.Print("TestFunction is being called from the C# code!");
	}
}
