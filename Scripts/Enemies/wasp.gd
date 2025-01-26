extends CharacterBody2D


@export var direction_change_interval: float = 2.0
@export var max_health: int = 100
@export var movement_type : String
@export var damage : int = 0

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_health: int
var SPEED = 20.0
var in_range = false
var free = true
var aggro = false

# Internal timer to track direction changes
var direction_timer: float = 0.0
var current_direction: Vector2 = Vector2.ZERO

# Ensures randomness is different each run



func choose_random_direction():
	# Generate a random unit vector for movement
	current_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _ready() -> void:
	current_health = max_health
	randomize()
func _physics_process(_delta):
	
	if aggro:
		if !free:
			SPEED = 0
		else:
			var direction = global_position.direction_to(player.global_position)
			velocity = direction * SPEED
			move_and_slide()
	elif !aggro:
		direction_timer -= _delta
		
		# Change direction if the timer runs out
		if direction_timer <= 0:
			direction_timer = direction_change_interval
			choose_random_direction()
	
		velocity = current_direction * SPEED
		move_and_slide()

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
func take_damage(amount: int) -> void:
	free = false
	sprite.play("damage")
	current_health -= amount
	

	# Check if the enemy is dead
	if current_health <= 0:
		die()

func die() -> void:
	queue_free()

func _on_aggro_body_entered(body: Node2D) -> void:
	aggro = true


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1) 
