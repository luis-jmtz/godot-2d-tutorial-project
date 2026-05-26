extends Area2D

@export var speed = 400
var screen_size # size of the game window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size= get_viewport_rect().size
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # Player's movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed # prevents diagonal movement from being faster
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	# updating player position and clamping it to keep it in-bounds
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# play correct animation
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		
		# flips the animation if moving left
		$AnimatedSprite2D.flip_h = velocity.x < 0 # velocity.x < 0 is a boolean that returns true or false
		# when x velocity is less than 0 (moving zero), it returns true, so flip_h (flip horizontal) is true.
		
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
		
