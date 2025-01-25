extends CharacterBody2D


const SPEED = 500.0


func _physics_process(delta):
	var direction := Input.get_vector("Left","Right","Up","Down")
	velocity = SPEED * direction.normalized()
		
	move_and_slide()
