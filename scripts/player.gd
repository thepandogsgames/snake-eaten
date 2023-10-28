class_name Player
extends Area2D

signal hit
const PlayerInput = preload("res://scripts/player_input.gd")

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var player_input_controller: PlayerInput

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player_input_controller = PlayerInput.new()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = player_input_controller.handle_player_input()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
		if velocity.x != 0:
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_v = false
			$AnimatedSprite2D.flip_h = true
		elif velocity.y != 0:
			$AnimatedSprite2D.animation = "up"
			$AnimatedSprite2D.flip_v = false
			
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
