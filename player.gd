extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 10.0  # Optional
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var direction = Vector3.ZERO

	# WASD / arrow input
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed("ui_up"):
		direction.z -= 1

	direction = direction.normalized()

	# Set horizontal movement
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Gravity handling
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# Move the cube respecting collisions and gravity
	move_and_slide()
