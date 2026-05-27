extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# gets list of all animation names
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	
	# selects animation randomly by picking a random animation name and setting .animation to that name/value
	$AnimatedSprite2D.animation = mob_types.pick_random()
	
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

# removes mob when it is no longer visible on the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # "frees" or deletes the node at the end of the frame.
