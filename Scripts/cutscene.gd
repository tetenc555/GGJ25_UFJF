extends Control

func _on_pass_pressed() -> void:
	SceneController.changeSceneTo("res://Scenes/game.tscn", "CircleToon")
