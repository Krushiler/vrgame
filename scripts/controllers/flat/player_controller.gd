extends Node3D

@export var player: Character
@export var camera: Camera3D
	
@export var mouse_sensitivity = 0.25
	
func _input(event):  		
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera.rotate_x(-event.relative.y * mouse_sensitivity * 0.01)
		player.rotate_y(-event.relative.x * mouse_sensitivity * 0.01)
		camera.global_rotation.x = clampf(camera.rotation.x, -deg_to_rad(90), deg_to_rad(90))
	elif event is InputEventKey and event.is_action_pressed("respawn"):
		player.state_machine.on_damage_taken(player.health)

func _physics_process(delta: float) -> void:
	var x_input = float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left"))
	var z_input = float(Input.is_action_pressed("move_back")) - float(Input.is_action_pressed("move_forward"))
	var jump_input = float(Input.is_action_just_pressed("jump"))
	var shoot = Input.is_action_pressed("weapon_shoot")
	var swap = Input.is_action_just_pressed("weapon_swap")

	player.x_input = x_input
	player.z_input = z_input
	player.jump_input = jump_input
	player.shoot_input = shoot
	player.swap_item_input = swap
