extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

var travelling_time
var projectile_speed
var damage
var direction: Vector2 = Vector2.ZERO

# Signal to notify when the projectile is destroyed
signal projectile_destroyed

func _ready():
	timer.wait_time = travelling_time  # Usando a variável que foi passada no momento da instanciação
	timer.start()
	collision.disabled = false
	connect("body_entered", Callable(self, "_on_body_entered"))

# Makes the projectile move in the right direction with the right speed
func _physics_process(delta: float) -> void:
	global_position += direction * projectile_speed * delta

# Sets the direction for the projectile
func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

# Handle collision with a body
func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(10)  # Example: deal 10 damage
	emit_signal("projectile_destroyed")

func _on_timer_timeout() -> void:
	queue_free()
