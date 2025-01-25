extends Node2D

@onready var spawnInimigoTimer = $spawnInimigo
@onready var player = $BubbleGuy

@export var spawn_radius: float = 300
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnInimigoTimer.start() #spawns enemy in 5 seconds! Please change this as enemys should be called. this is only to be generic and alpha testing purpouses.
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_inimigo_timeout() -> void: #maybe the enemy should be passed as parameter. This should be more generic
	var new_enemy = preload("res://Scenes/inmigodasilva.tscn").instantiate()
	var spawnPos = get_spawn_pos()
	
	if is_valid_spawn(spawnPos):
		new_enemy.global_position = spawnPos #positionStart + Vector2(-20,20)
	if (new_enemy != null):
		add_child(new_enemy)
		var positionStart= player.global_position
	pass # Replace with function body.
func get_spawn_pos():
		return Vector2(randf_range(-100,100), randf_range(70,-90))
func is_valid_spawn(spawnPos: Vector2) -> bool:
	var distance_to_player = player.position.distance_to(spawnPos)
	print(distance_to_player)
	return distance_to_player > spawn_radius
