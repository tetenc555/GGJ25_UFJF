extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
const SPEED = 100.0
var life = 100.0

func _ready():
	life = 100.0

func decrease_life(amount):
	if (amount>0):
		life-=amount;
	if (life <0):
		life = 0;
	
func increase_life(amount):
	if (amount>0 || life<100):
		life+=amount;
	if (life>100):
		life=100

func _physics_process(delta):
	var direction := Input.get_vector("Left","Right","Up","Down")
	velocity = SPEED * direction.normalized()
	
	if Input.is_action_pressed("Run"):
		velocity *= 1.4
	
	updateSprite()
	move_and_slide()

func updateSprite():
	if velocity.x:
		sprite.play("runHorizontal")
	elif velocity.y:
		if velocity.y > 0:
			sprite.play("runDown")
		elif velocity.y < 0:
			sprite.play("runUp")
	else:
		sprite.play("idle")
	
	if velocity.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
		
# Projectile Logic - Working
@export var Projectile : PackedScene = preload("res://Cenas/Projectile.tscn")
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
func shoot():
	var b = Projectile.instantiate()
	owner.add_child(b)
	b.transform = $Shooter.global_transform
