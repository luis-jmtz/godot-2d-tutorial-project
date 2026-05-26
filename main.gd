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
