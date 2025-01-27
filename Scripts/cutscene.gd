extends Control

func _ready():
	AudioPlayer.play_music_level()

func _on_pass_pressed() -> void:
	SceneController.changeSceneTo("res://Scenes/game.tscn", "CircleToon")
