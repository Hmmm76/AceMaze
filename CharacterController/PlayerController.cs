using Godot;
using System;
using System.Security;

public partial class PlayerController : CharacterBody2D
{
	[Export] private int speed = 100;
	private Vector2 currentVelocity;
	[Export] private AnimatedSprite2D _animatedSprite;
	
	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);

		handleInput();

		Velocity = currentVelocity;
		MoveAndSlide();
	}

	public override void _Process(double delta)
	{
		GD.Print(currentVelocity.X, currentVelocity.Y);
		base._Process(delta);
	}

	private void handleInput()
	{
		currentVelocity = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
		currentVelocity *= speed;

		if (Input.IsActionPressed("ui_left"))
		{
			_animatedSprite.Play("Walk_left");
		}
		else if (Input.IsActionPressed("ui_right"))
		{
			_animatedSprite.Play("Walk_right");
		}
		else if (Input.IsActionPressed("ui_up"))
		{
			_animatedSprite.Play("Walk_forward");
		}
		else if (Input.IsActionPressed("ui_down"))
		{
			_animatedSprite.Play("Walk_back");
		}
		
		
		else if (Input.IsActionJustReleased("ui_down"))
		{
			_animatedSprite.Play("Idle");
		}
		else if (Input.IsActionJustReleased("ui_up"))
		{
			_animatedSprite.Play("Idle_back");
		}
		else if (Input.IsActionJustReleased("ui_left"))
		{
			_animatedSprite.Play("Idle_left");
		}
		else if (Input.IsActionJustReleased("ui_right"))
		{
			_animatedSprite.Play("Idle_right");
		}
	}
}
