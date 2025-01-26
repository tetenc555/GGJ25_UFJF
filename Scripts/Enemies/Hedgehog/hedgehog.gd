extends CharacterBody2D

@export var max_health: int = 100
@onready var timer = $Timer
@export var SPEED = 100.0
@export var movement_type : String
@export var direction := Vector2i(0,0)
var current_health: int

func _ready() -> void:
	# Initialize health
	current_health = max_health

func _physics_process(_delta):
	
	
	move()
# Method to take damage
func take_damage(amount: int) -> void:
	current_health -= amount

	# Check if the enemy is dead
	if current_health <= 0:
		die()

# Method to handle enemy death
func die() -> void:
	# Add death logic here, e.g., play animation, emit signal, or remove from scene
	queue_free()


func _on_timer_timeout():
	direction = -direction

func move():
	return
	if movement_type == "H":
		if direction.x:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	elif movement_type == "V":
		if direction.y:
			velocity.y = direction.y * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
