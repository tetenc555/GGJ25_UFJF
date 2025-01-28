extends Node2D

@onready var weapons: Dictionary = {
	"Splasher": $Splasher,
	"Pistol": $Pistol,
	"Shotgun": $Shotgun
}

var weapon_actions: Dictionary = {
	"Splasher": "Splasher",
	"Pistol": "Pistol",
	"Shotgun": "Shotgun"
}

func _process(_delta: float) -> void:
	check_weapon_switch()

func check_weapon_switch() -> void:
	for weapon_name in weapon_actions:
		if Input.is_action_just_pressed(weapon_actions[weapon_name]):
			switch_weapon(weapon_name)
			break

func switch_weapon(selected_weapon: String) -> void:
	for weapon in weapons:
		weapons[weapon].desactivated = weapon != selected_weapon
		
