extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var SPEED = 70.0
var life = 2
var didnt_pop = true
var free = true
var invincible = false
var dying = false

func take_damage(amount):
	if !invincible:
		if (amount>0):
			life-=amount;
		if (life <= 0):
			die();

func _physics_process(_delta):
	if !free:
		SPEED = 0
		invincible = true
		return
	if SPEED == 0:
		SPEED = 70
	if life == 1 and didnt_pop:
		sprite.play("damage")
		didnt_pop = false
		free = false
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
	if free == true:
		if life == 1:
			if velocity:
				sprite.play("move")
			elif !velocity:
				sprite.play("idle")
		elif life == 2:
			if velocity:
				sprite.play("move_bubble")
			elif !velocity:
				sprite.play("idle_bubble")
	
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
		
func die() -> void:
	if dying == false:
		sprite.play("idle")
		free = false
		dying = true
		SceneController.reloadCurrentScene("Diamond")


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "damage":
		free = true
		invincible = false
