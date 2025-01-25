extends Node2D

@onready var spawnInimigoTimer = $spawnInimigo
@onready var player = $BubbleGuy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnInimigoTimer.start() #spawns enemy in 5 seconds! Please change this as enemys should be called. this is only to be generic and alpha testing purpouses.
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_inimigo_timeout() -> void: #maybe the enemy should be passed as parameter. This should be more generic
	var new_enemy = preload("res://Scenes/inmigodasilva.tscn").instantiate()
	new_enemy.global_position = Vector2(-50,50) #positionStart + Vector2(-20,20)
	if (new_enemy != null):
		add_child(new_enemy)
		var positionStart= player.global_position
	pass # Replace with function body.
