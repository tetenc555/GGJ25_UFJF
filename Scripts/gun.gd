extends Node2D

@onready var spawn: Node2D = $Spawn
@onready var sprite: Sprite2D = $Sprite2D

@export var projectile_scene: PackedScene = preload("res://Scenes/projectile.tscn") 
@export var bullet_decay_time : float 
@export var random_decay : bool
@export var min_decay : float
@export var max_decay : float
@export var damage : int
@export var fire_rate : int
@export var max_ammo : int
@export var projectile_speed : int
@export var desactivated := false


var direction

func _process(delta):
	if desactivated:
		visible = false
		return
	visible = true
		
	if random_decay:
		bullet_decay_time = randomize_timer()
	direction = global_position.direction_to(get_global_mouse_position())
	if rotation > 1.5 or rotation < -1.5:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	rotation = direction.angle()
	if Input.is_action_pressed("Fire"):
		check_cooldown()

func check_cooldown():
	shoot_projectile()

func shoot_projectile():
	var projectile_instance = projectile_scene.instantiate()
	pass_variables(projectile_instance)
	get_tree().root.add_child(projectile_instance)
	projectile_instance.global_position = spawn.global_position
	projectile_instance.set_direction(direction)

	projectile_instance.projectile_speed = projectile_speed

func pass_variables(projectile):
	projectile.travelling_time = bullet_decay_time
	projectile.projectile_speed = damage
	projectile.damage = damage

func randomize_timer():
	return randf_range(min_decay, max_decay)
	
	
	
