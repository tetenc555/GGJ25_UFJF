extends CharacterBody2D

# Enemy health
@export var max_health: int = 100
var current_health: int

func _ready() -> void:
	# Initialize health
	current_health = max_health

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
