extends Node2D

@export var enemy_scene: PackedScene
var score

func _ready():
	var timers = $Timers
	new_game()


func _process(delta):
	pass

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$Timers/StartTimer.start()

func game_over():
	$Timers/ScoreTimer.stop()
	$Timers/EnemyTimer.stop()


func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$Timers/EnemyTimer.start()
	$Timers/ScoreTimer.start()


func _on_enemy_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("SpawnerEnemies/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
