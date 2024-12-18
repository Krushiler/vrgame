class_name Weapon extends Node3D

@export var damage: int
@export var fire_mode: FireMode
@export var bullet_pivot: Node3D
@export var firerate: float
@export var bullet_pivot_override: Node3D = null
@export_flags_3d_physics var bulleet_collision_mask: int

var shooting: bool = false
var did_shoot: bool = false

var shoot_timer: float = 0

func get_bullet_pivot() -> Node3D:
	if bullet_pivot_override != null:
		return bullet_pivot_override
	return bullet_pivot

func can_shoot_fire_mode() -> bool:
	if fire_mode is SingleFireMode:
		return !did_shoot
	elif fire_mode is AutoFireMode:
		return true
	return false

func set_shooting(shoot: bool):
	shooting = shoot
	if not shoot:
		did_shoot = false

func get_shoot_delay() -> float:
	return 1 / (firerate / 60)
	
func _physics_process(delta: float) -> void:
	if shoot_timer > 0:
		shoot_timer -= delta
		
	if shooting and can_shoot_fire_mode() and shoot_timer <= 0:
		_shoot()
	

func _shoot():	
	did_shoot = true
	shoot_timer = get_shoot_delay()
	var pivot = get_bullet_pivot()
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(
		pivot.global_position, 
		pivot.global_position - pivot.global_transform.basis.z * 1000,
		bulleet_collision_mask
		)
	query.collide_with_areas = true
	var collision = space_state.intersect_ray(query)
	if not collision:
		return
	EventBus.hit_applied.emit(self, collision, damage)
