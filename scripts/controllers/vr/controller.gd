extends XRController3D

@export var primary: bool = true
@export var player: Character

func _ready() -> void:
	input_float_changed.connect(_input_float_changed)
	button_pressed.connect(_button_pressed)
	input_vector2_changed.connect(_input_vector_changed)
	
func _physics_process(delta: float) -> void:
	if not primary:
		var value = get_vector2('primary')
		var direction = value.rotated(rotation.y)
		player.x_input = direction.x
		player.z_input = -direction.y
	
func _input_vector_changed(name: String, value: Vector2):
	pass
	
func _button_pressed(name: String):
	if primary:
		if name == 'by_button':
			player.swap_weapon()
		if name == 'ax_button':
			player.jump()
	else:
		if name == 'ax_button':
			player.respawn()
	
func _input_float_changed(name: String, value: float):
	if primary:
		if name == 'trigger':
			player.shoot_input = value >= 0.5
