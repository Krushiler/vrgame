extends Node

func _ready() -> void:
	EventBus.player_died.connect(_on_player_died)

func _on_player_died(player: Character):
	pass
	#player.respawn()
