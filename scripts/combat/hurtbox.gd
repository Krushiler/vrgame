class_name HurtBox extends Node

@export var blood_particle_scene = preload("res://scenes/particles/blood.tscn")

signal damage_taken(from: Node3D, damage: int)

func take_damage(from: Node3D, damage: int):
	damage_taken.emit(from, damage)

func make_hitmark(normal: Vector3, position: Vector3):
	var particle: GPUParticles3D = blood_particle_scene.instantiate()
	add_child(particle)
	particle.global_position = position + normal * 0.05
	particle.look_at(position - normal + Vector3(0.001, 0.0, 0.0))
	particle.emitting = true
