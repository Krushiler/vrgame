extends CharacterState

func on_enter():
	character.died.emit()
	character.mesh.mesh.material.albedo_color = character.dead_color
	
func on_damage_taken(damage: int):
	pass

func on_exit():
	character.respawned.emit()
	character.mesh.mesh.material.albedo_color = character.default_color
