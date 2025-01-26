extends Area2D

var cooldown = false
var body_in_area: CharacterBody2D = null
@onready var cooldownTimer = $Cooldown
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var damage : int

func _on_body_entered(body: CharacterBody2D) -> void:
	if body_in_area == null:  
		body_in_area = body
		if not cooldown:
			cooldownTimer.start()
			apply_damage()

func _on_body_exited(body: CharacterBody2D) -> void:
	if body == body_in_area:
		body_in_area = null  

func _on_cool_down_timeout() -> void:
	cooldown = false
	if body_in_area != null: 
		apply_damage()
		cooldownTimer.start()


func apply_damage() -> void:
	sprite.play("damage")
	if body_in_area != null:
		body_in_area.take_damage(damage)
