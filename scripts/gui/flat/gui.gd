extends CanvasLayer

@export var player: Character

@onready var gui_tree = {
	'alive': $AliveGui,
	'dead': $DeadGui
}

func _ready() -> void:
	_show('alive')
	player.respawned.connect(func (): _show('alive'))
	player.died.connect(func (): _show('dead'))

func _show(route: String):
	for gui in gui_tree.values():
		gui.visible = false
				
	gui_tree[route].visible = true
	gui_tree[route].on_enter()
