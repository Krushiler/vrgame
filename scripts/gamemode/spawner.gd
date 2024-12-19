extends Node

func _ready() -> void:
	EventBus.player_respawned.connect(_on_player_respawned)
	
func _on_player_respawned(player: Character):
	var spawn = get_children().pick_random()
	player.global_position = spawn.global_position
	player.reset()
