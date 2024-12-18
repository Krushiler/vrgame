extends CharacterState

func on_physics_process(delta: float):
	character.process_shooting()
	character.process_movement(delta)
