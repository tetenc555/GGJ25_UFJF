extends Node2D


@export var projectile_scene: PackedScene = preload("res://Cenas/Projectile.tscn")  # Path to your projectile scene

func _process(delta):
	if Input.is_action_just_pressed("fire"):  # Check if the fire button is pressed
		shoot_projectile()

func shoot_projectile():
	# Instantiate the projectile from the PackedScene
	var projectile_instance = projectile_scene.instantiate()
	# Sets the default direction being down so it matches the sprite position
	var direction := Vector2(0,1)
	# If any directional input is pressed it changes the direction to that input to match the sprite
	if Input.get_vector("AimLeft","AimRight","AimNorth","AimSouth"):
		direction = Input.get_vector("AimLeft","AimRight","AimNorth","AimSouth")
	print(direction)	
	# Set the initial position of the projectile in front of the player
	projectile_instance.position = get_parent().position + direction  # Example offset

	# Set the direction of the projectile
	projectile_instance.set_direction(direction) 

	# Set the speed of the projectile (this is a custom variable defined in the projectile script)
	projectile_instance.speed = 400  # Set speed properly here (this value has priority over the projectile script )

	# Add the projectile to the scene
	get_parent().add_child(projectile_instance)
