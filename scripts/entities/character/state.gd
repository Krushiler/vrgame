class_name CharacterState extends State

signal argument_changed(state: String, value)

var character: Character

func init(character: Character):
	self.character = character
		
func on_damage_taken(damage: int):
	pass
