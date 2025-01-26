extends Node2D

@onready var splasher: Node2D = $Splasher
@onready var pistol: Node2D = $Pistol
@onready var shotgun: Node2D = $Shotgun
@onready var flask: Node2D = $Flask
@onready var slingshot: Node2D = $Slingshot

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Splasher"):
		pistol.desactivated = true
		splasher.desactivated = false
		shotgun.desactivated = true
		slingshot.desactivated = true
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Pistol"):
		pistol.desactivated = false
		splasher.desactivated = true
		shotgun.desactivated = true
		slingshot.desactivated = true
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Shotgun"):
		pistol.desactivated = true
		splasher.desactivated = true
		shotgun.desactivated = false
		slingshot.desactivated = true
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Slingshot"):
		pistol.desactivated = true
		splasher.desactivated = true
		shotgun.desactivated = true
		slingshot.desactivated = false
		flask.desactivated = true
		
	if Input.is_action_just_pressed("Flask"):
		pistol.desactivated = true
		splasher.desactivated = true
		shotgun.desactivated = true
		slingshot.desactivated = true
		flask.desactivated = false
