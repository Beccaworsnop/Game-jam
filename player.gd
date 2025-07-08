extends CharacterBody3D

@export var speed: float = 5.0

func _physics_process(delta):
	# Get input direction
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1
	
	# Normalize direction for consistent speed
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y = 0  # No gravity for now, keep it simple
	
	# Move the character
	move_and_slide()
	
	# Debug print to see if script is running
	if direction.length() > 0:
		print("Moving: ", direction)
