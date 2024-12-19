class_name CharacterState extends State

signal argument_changed(state: String, value)

var character: Character

func init(character: Character):
	self.character = character
		
func on_damage_taken(damage: int):
	character.health -= damage
	if character.health <= 0:
		change_state('dead')
		EventBus.player_died.emit(character)
