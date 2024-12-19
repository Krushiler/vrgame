extends Node

@export var player: Character

@onready var dead_gui = $Control

func _ready() -> void:
	dead_gui.visible = false
	player.died.connect(func (): dead_gui.visible = true)
	player.respawned.connect(func (): dead_gui.visible = false)
