extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 70.0
var life = 100.0

func _ready():
	life = 100.0

func decrease_life(amount):
	if (amount>0):
		life-=amount;
	if (life <0):
		die();
		
	
func increase_life(amount):
	if (amount>0 || life<100):
		life+=amount;
	if (life>100):
		life=100

func _physics_process(_delta):
	var direction := Input.get_vector("Left","Right","Up","Down")
	velocity = SPEED * direction.normalized()
	
	if Input.is_action_pressed("Run"):
		velocity *= 1.3
		sprite.speed_scale = 2
	else:
		sprite.speed_scale = 1
	
	update_animation()
	move_and_slide()

func update_animation():
	if velocity:
		sprite.play("move")
	else:
		sprite.play("idle")
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
func die() -> void:
	# Add death logic here, e.g., play animation, emit signal, or remove from scene
	queue_free()
