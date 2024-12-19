extends XROrigin3D

@export var player: Character

func _physics_process(delta: float) -> void:
	global_position = player.head_pivot.global_position
