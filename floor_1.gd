extends StaticBody3D

func _ready():
	await get_tree().create_timer(2.0).timeout
	$CollisionShape3D.disabled = true  # Makes the platform not solid after 2 seconds
