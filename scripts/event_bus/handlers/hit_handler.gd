extends Node

var hole_scene = preload("res://scenes/misc/bullet_hole.tscn")

func _ready() -> void:
	EventBus.hit_applied.connect(_on_hit_applied)
	
func _on_hit_applied(from: Node3D, collision: Dictionary, damage: int):
	if collision.collider.has_method("take_damage"):
		collision.collider.take_damage(from, damage)
	if collision.collider.has_method("make_hitmark"):
		collision.collider.make_hitmark(collision.normal, collision.collider.global_position)
	else:
		var hole: Node3D = hole_scene.instantiate()
		collision.collider.add_child(hole)
		hole.global_position = collision.position + collision.normal * 0.005
		hole.look_at(collision.position + collision.normal + Vector3(0.001, 0.0, 0.0))
