extends CharacterBody2D

@export var projectile_scene: PackedScene = preload("res://Scenes/Enemies/dart.tscn") 
@export var max_health: int = 100
@onready var timer = $Timer
@onready var cooldown: Timer = $Cooldown
@export var movement_type : String
@export var multishot : int = 1
@export var projectile_speed : int = 50
@export var bullet_decay_time : int = 1
@export var damage : int = 0

var aggro = true
var current_health: int
var direction : Vector2i
var projectile_direction = Vector2(1,1)
var SPEED = 20.0


func _ready() -> void:
	current_health = max_health

func _physics_process(_delta):
	if aggro:
		check_cooldown()
	
	if movement_type == "H":
		direction = Vector2i(1,0)
		if direction.x:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	elif movement_type == "V":
		direction = Vector2i(0,1)
		if direction.y:
			velocity.y = direction.y * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func take_damage(amount: int) -> void:
	current_health -= amount

	# Check if the enemy is dead
	if current_health <= 0:
		die()

# Method to handle enemy death
func die() -> void:
	queue_free()


func check_cooldown():
	if cooldown.time_left == 0:
		shoot_projectile()
		cooldown.start()
	else:
		pass

func shoot_projectile():
	if multishot == 1:
		shoot_in_direction(projectile_direction)
	else:
		var spread_angle = 360
		var angle_step = spread_angle / (multishot - 1)
		for i in range(multishot):
			var angle_offset = (i - (multishot - 1) / 2) * angle_step
			shoot_in_direction(projectile_direction.rotated(deg_to_rad(angle_offset)))

func shoot_in_direction(_direction):
	var projectile_instance = projectile_scene.instantiate()
	
	get_tree().root.add_child(projectile_instance)
	projectile_instance.global_position = global_position
	projectile_instance.set_direction(_direction)
	projectile_instance.projectile_speed = projectile_speed
	
func pass_variables(projectile):
	projectile.travelling_time = bullet_decay_time
	projectile.projectile_speed = projectile_speed
	projectile.damage = damage


func _on_timer_timeout() -> void:
	direction = - direction
