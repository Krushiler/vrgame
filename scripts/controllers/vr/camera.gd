extends XRCamera3D

@export var player: Character

func _physics_process(delta: float) -> void:
	player.position_correction = position
	player.rotation_correction.y = rotation.y
