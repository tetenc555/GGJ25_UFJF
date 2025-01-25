extends CharacterBody2D


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
	
	move_and_slide()

@export var Projectile : PackedScene = preload("res://Cenas/Projectile.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Fire"):
		fire()
		
func fire():
	
	var b = Projectile.instantiate()
	get_tree().root.add_child(b)
	
