class_name Character extends CharacterBody3D

signal respawned()
signal died()

@export var item_pivot: ItemPivot
@export var walk_speed = 5.0
@export var jump_velocity = 4.5
@export var max_health: int = 100
@export var default_color: Color
@export var dead_color: Color

@onready var hurtbox: HurtBox = $HurtBox
@onready var head_pivot: Node3D = $HeadPivot
@onready var state_machine: CharacterStateMachine = $StateMachine
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var collision: CollisionShape3D = $CollisionShape3D

var position_correction: Vector3 = Vector3.ZERO
var rotation_correction: Vector3 = Vector3.ZERO

var dead_material = preload("res://shaders/player_dead.tres")

var x_input: float = 0
var z_input: float = 0
var jump_input: float = 0
var shoot_input: bool = false
var swap_item_input: bool = false
var health: int

func respawn():
	if health <= 0:
		EventBus.player_respawned.emit(self)
	
func reset():
	health = max_health
	state_machine._on_state_changed('moving')
	
func jump():
	jump_input = 1

func _ready() -> void:
	health = max_health
	state_machine.init(self)
	hurtbox.damage_taken.connect(func (from, damage): state_machine.on_damage_taken(damage))
	respawned.emit()
	mesh.mesh.material.albedo_color = default_color

func process_shooting():
	if item_pivot.held_item.has_method("set_shooting"):
		item_pivot.held_item.set_shooting(shoot_input)
		
func swap_weapon():
	item_pivot.swap_weapon()
	
func process_movement(delta: float):
	if swap_item_input:
		swap_weapon()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		jump_input = 0

	if is_on_floor():
		velocity.y = jump_input * jump_velocity
		
	var direction = (transform.basis * Vector3(x_input, 0, z_input)).normalized() * clampf(max(abs(x_input), abs(z_input)), 0, 1)
	var target_velocity = Vector3(direction.x * walk_speed, velocity.y, direction.z * walk_speed)

	velocity = lerp(velocity, target_velocity, sqrt(delta) / 2)
	
	collision.position = position_correction
	collision.rotation = rotation_correction
	hurtbox.position = position_correction
	hurtbox.rotation = rotation_correction
	mesh.position = position_correction
	mesh.rotation = rotation_correction

	move_and_slide()
	
