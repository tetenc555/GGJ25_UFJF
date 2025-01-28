extends Node2D

@onready var spawn: Node2D = $Spawn
@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

@export var projectile_scene: PackedScene = preload("res://Scenes/bubble.tscn") 
@export var bullet_decay_time: float = 2.0
@export var random_decay: bool = false
@export var min_decay: float = 0.5
@export var max_decay: float = 3.0
@export var damage: int = 1
@export var fire_rate: float = 1.0
@export var projectile_speed: int = 300
@export var desactivated := false:
	set(value):
		desactivated = value
		_update_visibility()
@export var multishot: int = 1
@export var spread_angle: float = 45.0
@export var random_spawn: bool = false
@export var min_random_angle: float = -60.0
@export var max_random_angle: float = 45.0

var _current_decay: float
var direction


func _ready():
	timer.wait_time = 1.0 / fire_rate
	_update_visibility()


func _process(_delta):
	if desactivated:
		return
	
	_update_aim()
	
	if Input.is_action_pressed("Fire"):
		_try_shoot()


func _update_visibility():
	visible = not desactivated


func _update_aim():
	var mouse_pos = get_global_mouse_position()
	direction = global_position.direction_to(mouse_pos)
	
	rotation = direction.angle()
	sprite.flip_v = abs(direction.angle()) > deg_to_rad(85)


func _try_shoot():
	if timer.is_stopped():
		_prepare_shot()
		timer.start()


func _prepare_shot():
	if random_decay:
		_current_decay = randf_range(min_decay, max_decay)
	else:
		_current_decay = bullet_decay_time
	
	if multishot > 1:
		_fire_spread_shot()
	else:
		_fire_single_shot(direction)


func _fire_spread_shot():
	var angle_step = spread_angle / (multishot - 1) if multishot > 1 else 0.0
	var start_angle = -spread_angle / 2.0
	
	for i in multishot:
		var angle_offset = start_angle + (i * angle_step)
		var shot_direction = direction.rotated(deg_to_rad(angle_offset))
		_fire_single_shot(shot_direction)


func _fire_single_shot(base_direction: Vector2):
	var final_direction = base_direction
	
	if random_spawn:
		var random_angle = deg_to_rad(randf_range(min_random_angle, max_random_angle))
		final_direction = base_direction.rotated(random_angle)
	
	var projectile = projectile_scene.instantiate()
	_configure_projectile(projectile, final_direction)
	get_tree().root.add_child(projectile)


func _configure_projectile(projectile: Node, direction: Vector2):
	projectile.global_position = spawn.global_position
	projectile.damage = damage
	projectile.travelling_time = _current_decay
	projectile.projectile_speed = projectile_speed + get_parent().get_parent().velocity.length()
	projectile.set_direction(direction)
