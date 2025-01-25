extends Area2D
#Projectile is working but it only shoots to the right
var speed = 75.0

func _process(delta):
	position += transform.x * speed * delta

	
#No use yet
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
