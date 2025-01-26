extends CharacterBody2D

@export var projectile_scene: PackedScene = preload("res://Scenes/Enemies/dart.tscn") 
@export var max_health: int = 100
@export var movement_type : String
@export var multishot : int = 1
@export var projectile_speed : int = 50
@export var bullet_decay_time : int = 1
@export var damage : int = 0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var spawn: Node2D = $Spawn
@onready var cooldown: Timer = $Cooldown
@onready var player = get_tree().get_first_node_in_group("Player")

var current_health: int
var projectile_direction = Vector2(1,1)
var SPEED = 20.0
var in_range = false
var free = true


func _ready() -> void:
	current_health = max_health

func _physics_process(_delta):
	if !free:
		SPEED = 0
	if in_range:
		check_cooldown()
	else:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
		update_animation()
		move_and_slide()


func take_damage(amount: int) -> void:
	free = false
	sprite.play("damage")
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
	projectile_direction = randomize_direction()
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
	
	sprite.play("attack")
	get_tree().root.add_child(projectile_instance)
	projectile_instance.global_position = global_position
	
	projectile_instance.set_direction(_direction)
	projectile_instance.rotation = _direction.angle() + -80
	
func pass_variables(projectile):
	projectile.travelling_time = bullet_decay_time
	projectile.projectile_speed = projectile_speed
	projectile.damage = damage
	
func update_animation():
	if free:
		if velocity:
			sprite.play("move")
		else:
			sprite.play("idle")
		
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0:
			sprite.flip_h = true
	elif !free:
		return

func _on_stop_body_entered(body: Node2D) -> void:
	in_range = true

func _on_stop_body_exited(body: Node2D) -> void:
	in_range = false


func _on_invisible_area_exited(area: Area2D) -> void:
	area.disabled = false

func randomize_direction():
	var x = Vector2(15,0)
	var y = Vector2(0,15)
	var random_vector = Vector2(
		randf_range(x.x, y.x),
		randf_range(x.y, y.y)
	)
	return random_vector


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "damage":
		SPEED = 20
		free = true
