extends SpringArm3D

@export var mouse_sensibility: float = 0.005

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensibility
