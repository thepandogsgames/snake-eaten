class_name PlayerInput
extends Node


func handle_player_input() -> Vector2:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		return move_right(velocity)
	if Input.is_action_pressed("move_left"):
		return move_left(velocity)
	if Input.is_action_pressed("move_down"):
		return move_down(velocity)
	if Input.is_action_pressed("move_up"):
		return move_up(velocity)
		
	return velocity
	
func move_up(velocity: Vector2) -> Vector2:
	velocity.y -= 1
	return velocity
	
func move_down(velocity: Vector2) -> Vector2:
	velocity.y += 1
	return velocity
	
func move_left(velocity: Vector2) -> Vector2:
	velocity.x -= 1
	return velocity
	
func move_right(velocity: Vector2) -> Vector2:
	velocity.x += 1
	return velocity
	
