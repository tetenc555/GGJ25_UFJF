extends Node2D


@export var projectile_scene: PackedScene = preload("res://Scenes/Projectile.tscn")  # Path to your projectile scene
@export var projectile_speed = 0

func _process(delta):
	if Input.is_action_just_pressed("fire"):  # Check if the fire button is pressed
		shoot_projectile()
	rotation = 180

func shoot_projectile():
	var projectile_instance = projectile_scene.instantiate()
	var direction = global_position.direction_to(get_global_mouse_position())
	projectile_instance.position = get_parent().position + direction
	projectile_instance.set_direction(direction) 

	projectile_instance.speed = projectile_speed
	
	get_parent().add_child(projectile_instance)
