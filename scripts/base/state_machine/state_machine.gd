class_name StateMachine extends Node

var _state: State = null

var _state_row: Array[State] = []

func get_state() -> State:
	return _state

func _process(delta):
	if _state != null:
		_state.on_process(delta)
	

func _input(event):
	if _state != null:
		_state.on_input(event)
	

func _physics_process(delta):
	if _state != null:
		_state.on_physics_process(delta)
	

func pop() -> bool:
	if len(_state_row) > 1:
		_state_row.pop_front()
		_state.on_exit()
		_state = _state_row.front()
		_state.on_enter()
		return true
	return false

func set_state(state: State):
	_state_row.push_front(state)
	if len(_state_row) > 20:
		_state_row.pop_back()
	if _state != null:
		_state.on_exit()
	_state = state
	_state.on_enter()
