extends CharacterBody2D

# Enemy health
@export var max_health: int = 100
@onready var raycastLeft: RayCast2D = $RayCastLeft
@onready var raycastRight: RayCast2D = $RayCastRight
var direction = 1
var current_health: int
const SPEED = 200.0

func _ready() -> void:
	# Initialize health
	current_health = max_health

func _physics_process(delta):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if raycastRight.is_colliding():
		direction = -1
	if raycastLeft.is_colliding():
		direction = 1
	
	move_and_slide()
# Method to take damage
func take_damage(amount: int) -> void:
	current_health -= amount
	print("Enemy took damage. Current health: ", current_health)

	# Check if the enemy is dead
	if current_health <= 0:
		die()

# Method to handle enemy death
func die() -> void:
	print("Enemy has died!")
	# Add death logic here, e.g., play animation, emit signal, or remove from scene
	queue_free()
