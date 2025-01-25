extends Area2D

# Speed of the projectile
@export var speed: float = 40.0
# Direction of the projectile
var direction: Vector2 = Vector2.ZERO

# Signal to notify when the projectile is destroyed
signal projectile_destroyed

func _ready():
	$CollisionShape2D.disabled = false
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

# Sets the direction for the projectile
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

# Handle collision with a body
func _on_body_entered(body: Node) -> void:
	# Handle collision logic here
	if body.has_method("take_damage"):
		body.take_damage(10)  # Example: deal 10 damage

	emit_signal("projectile_destroyed")
	queue_free()
