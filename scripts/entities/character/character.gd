class_name Character extends CharacterBody3D

@export var item_pivot: ItemPivot
@export var walk_speed = 5.0
@export var jump_velocity = 4.5
@export var max_health: int = 100

@onready var hurtbox: HurtBox = $HurtBox
@onready var head_pivot: Node3D = $HeadPivot
@onready var state_machine: CharacterStateMachine = $StateMachine
@onready var mesh: MeshInstance3D = $MeshInstance3D

var dead_material = preload("res://shaders/player_dead.tres")

var x_input: float = 0
var z_input: float = 0
var jump_input: float = 0
var shoot_input: bool = false
var swap_item_input: bool = false
var health: int

func respawn():
	health = max_health
	state_machine._on_state_changed('moving')

func _ready() -> void:
	health = max_health
	state_machine.init(self)
	hurtbox.damage_taken.connect(func (from, damage): state_machine.on_damage_taken(damage))

func process_shooting():
	if item_pivot.held_item.has_method("set_shooting"):
		item_pivot.held_item.set_shooting(shoot_input)
	
func process_movement(delta: float):
	if swap_item_input:
		item_pivot.swap_weapon()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		velocity.y = jump_input * jump_velocity
		
	var direction = (transform.basis * Vector3(x_input, 0, z_input)).normalized() * clampf(max(abs(x_input), abs(z_input)), 0, 1)
	var target_velocity = Vector3(direction.x * walk_speed, velocity.y, direction.z * walk_speed)

	velocity = lerp(velocity, target_velocity, sqrt(delta) / 2)

	move_and_slide()
	
