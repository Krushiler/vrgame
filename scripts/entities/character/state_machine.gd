class_name CharacterStateMachine extends StateMachine

var character: Character

@onready var states = {
	'moving': get_node("Moving"),
	'dead': get_node("Dead"),
}

func init(character: Character):
	self.character = character
	
	for state in states.values():
		state.init(character)
		state.state_changed.connect(_on_state_changed);
		
	set_state(states['moving'])

func _on_argument_changed(state: String, argument):
	states[state].argument = argument
	
func _on_state_changed(state_name: String):
	match state_name:
		'pop': pop()
		_: set_state(states[state_name])

func on_damage_taken(damage: int):
	_state.on_damage_taken(damage)
