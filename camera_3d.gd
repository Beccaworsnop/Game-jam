
extends Camera3D

@export var target: Node3D  # Drag your player here in the inspector
@export var follow_speed: float = 5.0
@export var offset: Vector3 = Vector3(0, 5, 5)  # Camera position relative to player

func _process(delta):
	if target:
		var desired_position = target.global_position + offset
		global_position = global_position.lerp(desired_position, follow_speed * delta)
		look_at(target.global_position, Vector3.UP)
