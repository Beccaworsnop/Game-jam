extends Camera3D

@export var target: Node3D  # Drag your player here in the inspector
@export var follow_speed: float = 5.0
@export var offset: Vector3 = Vector3(0, 5, 5)  # Camera position relative to player
@export var collision_margin: float = 0.1  # Distance to keep from walls

@onready var ray_cast = $RayCast3D

func _ready():
	# Configure the raycast
	ray_cast.enabled = true
	ray_cast.collision_mask = 1  # Adjust based on your collision layers
	ray_cast.collide_with_areas = false
	ray_cast.collide_with_bodies = true

func _process(delta):
	if target:
		var desired_position = target.global_position + offset
		var collision_free_position = check_collision(target.global_position, desired_position)
		
		global_position = global_position.lerp(collision_free_position, follow_speed * delta)
		look_at(target.global_position, Vector3.UP)

func check_collision(start_pos: Vector3, end_pos: Vector3) -> Vector3:
	# Cast ray from player to desired camera position
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(start_pos, end_pos)
	query.collision_mask = 1  # Adjust based on your collision layers
	query.collide_with_areas = false
	query.collide_with_bodies = true
	
	var result = space_state.intersect_ray(query)
	
	if result:
		# If collision detected, place camera at collision point minus margin
		var collision_point = result.position
		var direction = (end_pos - start_pos).normalized()
		return collision_point - (direction * collision_margin)
	else:
		# No collision, use desired position
		return end_pos
