extends Node2D

@onready var splasher: Node2D = $Splasher
@onready var pistol: Node2D = $Pistol

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Splasher"):
		pistol.visible = false
		splasher.visible = true
	if Input.is_action_just_pressed("Pistol"):
		pistol.visible = true
		splasher.visible = false
