class_name ItemPivot extends Node

var weapon_1 = preload("res://scenes/weapons/pistol.tscn")
var weapon_2 = preload("res://scenes/weapons/uzi.tscn")

var first = false

@export var held_item: Node3D

@export var bullet_pivot_override: Node3D

func _ready() -> void:
	swap_weapon()

func swap_weapon():
	if held_item != null:
		remove_child(held_item)
	var weapon: Weapon
	if not first:
		weapon = weapon_1.instantiate()
	else:
		weapon = weapon_2.instantiate()
	first = !first
	add_child(weapon)
	weapon.bullet_pivot_override = bullet_pivot_override
	held_item = weapon
