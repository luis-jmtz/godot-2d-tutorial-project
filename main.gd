extends Node

@export var mob_scene: PackedScene
# A simplified interface to a scene file. Provides access to operations and checks
# that can be performed on the scene resource itself

var score


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()


func new_game():
	score = 0
	$Player.start($StartPosition.position) # start is a function from player
	$StartTimer.start()


# ====================================== Timer Timeouts =========================================================
# The Timer node is a countdown timer and is the simplest way to handle time-based logic in the engine.
# When a timer reaches the end of its wait_time, it will emit the timeout signal.

func _on_mob_timer_timeout(): # wait time = 0.5
	# creates a new instance of the Mob scene
	var mob = mob_scene.instantiate()
	
	# choose a random location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	
	# progress ratio: The distance along the path as a number in the range 0.0
	# (for the first vertex) to 1.0 (for the last)
	mob_spawn_location.progress_ratio = randf()

	# set the mob's postion to the random location
	mob.position = mob_spawn_location.position
	
	# set the mob's direction perpendicular to the path direction 
	var direction = mob_spawn_location.rotation + PI / 2 # 0 + pi/2
	
	# add some randomness to the direction
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	# choose the velocity for the mob
	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# spawns the mob by adding it to the Main scene
	add_child(mob)


func _on_score_timer_timeout():
	score += 1 # after 1 seconds (Inspector: Wait Time) increase score by 1


# after 2 seconds the game turns on mob spawning with the MobTimer and the score counting with ScoreTimer
func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	# .start() Starts the timer, or resets the timer if it was started already
