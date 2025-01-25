extends Node2D

@onready var spawn: Node2D = $Spawn

@export var projectile_scene: PackedScene = preload("res://Scenes/projectile.tscn") 
@export var traveling_time : int 
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
	direction = global_position.direction_to(get_global_mouse_position())
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
	projectile.travelling_time = traveling_time
	projectile.projectile_speed = damage
	projectile.damage = damage
	
