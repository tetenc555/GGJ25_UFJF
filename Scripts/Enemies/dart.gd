extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var sprite: Sprite2D = $Sprite2D

var travelling_time = 1
var projectile_speed = 50
var damage
var direction: Vector2 = Vector2.ZERO
var destructive = true
var disabled = true

func _ready():
	timer.wait_time = travelling_time 
	timer.start()
	collision.disabled = false

func _physics_process(delta: float) -> void:
	if !disabled:
		sprite.visible = true
		monitoring = true
	global_position += direction * projectile_speed * delta

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(1) 
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

func _on_killzone_body_entered(_body: Node2D) -> void:
	pass
