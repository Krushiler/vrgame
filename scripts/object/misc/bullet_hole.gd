extends Sprite3D

var timer: float = 10

var deleted = false

func _physics_process(delta: float) -> void:
	if not deleted:
		timer -= delta
		
		if timer <= 5 and timer >= 0:
			modulate.a = lerpf(0, 1, timer / 5)
		
		if timer <= 0:
			queue_free()
