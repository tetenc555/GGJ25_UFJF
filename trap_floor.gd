extends Area2D

var cooldown = false
var body_in_area: Node2D = null
@onready var cooldownTimer = $CoolDown

func _on_body_entered(body: Node2D) -> void:
	if body_in_area == null:  
		body_in_area = body  #defines player body
		if not cooldown:
			apply_damage()

func _on_body_exited(body: Node2D) -> void:
	if body == body_in_area:
		body_in_area = null  
		cooldownTimer.stop()  # Stop the cooldown timer

func _on_cool_down_timeout() -> void:
	cooldown = false
	if body_in_area != null:  # If the body still in the area it takes damage
		apply_damage()


func apply_damage() -> void:
	if body_in_area != null:
		body_in_area.decrease_life(20)  # Reduce life by 20
		cooldown = true
		cooldownTimer.start()
