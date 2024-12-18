class_name State extends Node

signal state_changed(name: String)

func pop():
	state_changed.emit('pop')

func change_state(name: String):
	state_changed.emit(name)

func on_enter():
	pass
	

func on_exit():
	pass
	

func on_input(event: InputEvent):
	pass
	

func on_process(delta: float):
	pass
	

func on_physics_process(delta: float):
	pass
