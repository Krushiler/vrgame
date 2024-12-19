extends Control

@export var player: Character

func on_enter():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	player.respawn()
