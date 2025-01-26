extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var travelling_time
var projectile_speed
var damage
var direction: Vector2 = Vector2.ZERO

func _ready():
	timer.wait_time = travelling_time 
	timer.start()
	collision.disabled = false
	
func _physics_process(delta: float) -> void:
	global_position += direction * projectile_speed * delta

func set_direction(new_direction: Vector2) -> void:
	direction = new_direction.normalized()

func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
func _on_timer_timeout() -> void:
	projectile_speed = 0
	sprite.play("pop")


func _on_killzone_body_entered(body: Node2D) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "pop":
		queue_free()
