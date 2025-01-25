extends Area2D
#Projectile should work, but it doesn't move when created
var speed = 7500

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
