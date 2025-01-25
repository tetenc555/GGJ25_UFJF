extends Node2D

@onready var spawn: Node2D = $Spawn
@export var projectile_scene: PackedScene = preload("res://Scenes/Projectile.tscn")  # Path to your projectile scene
@export var projectile_speed = 0

var direction

func _process(delta):
	direction = global_position.direction_to(get_global_mouse_position())
	rotation = direction.angle()
	if Input.is_action_pressed("fire"): 
		shoot_projectile()
	

func shoot_projectile():
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.position = spawn.global_position + direction
	projectile_instance.set_direction(direction) 

	projectile_instance.speed = projectile_speed
	
	get_parent().add_child(projectile_instance)
	
