extends Node2D

@onready var splasher: Node2D = $Splasher
@onready var pistol: Node2D = $Pistol
@onready var shotgun: Node2D = $Shotgun
@onready var flask: Node2D = $Flask

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Splasher"):
		pistol.desactivated = true
		splasher.desactivated = false
		shotgun.desactivated = true
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Pistol"):
		pistol.desactivated = false
		splasher.desactivated = true
		shotgun.desactivated = true
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Shotgun"):
		pistol.desactivated = true
		splasher.desactivated = true
		shotgun.desactivated = false
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Flask"):
		pistol.desactivated = true
		splasher.desactivated = true
		shotgun.desactivated = true
		flask.desactivated = false
