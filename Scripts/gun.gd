extends Node2D

@onready var spawn: Node2D = $Spawn
@onready var sprite: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer

@export var projectile_scene: PackedScene = preload("res://Scenes/projectile.tscn") 
@export var bullet_decay_time : float 
@export var random_decay : bool
@export var min_decay : float
@export var max_decay : float
@export var damage : int
@export var fire_rate : float
@export var max_ammo : int
@export var projectile_speed : int
@export var desactivated := false
@export var multishot : int
@export var manual := false
@export var explosive := false
@export var random_spawn := false
@export var bouncy := false

var direction
var velocity : Vector2 = Vector2.ZERO  # A velocidade do projétil

func _process(_delta):
	if desactivated:
		visible = false
		return
	visible = true
	
	timer.wait_time = 1/fire_rate
	if random_decay:
		bullet_decay_time = randomize_timer()
	direction = global_position.direction_to(get_global_mouse_position())
	if rotation > 1.5 or rotation < -1.5:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	rotation = direction.angle()
	if Input.is_action_pressed("Fire") and !manual:
		check_cooldown()
	elif manual:
		if Input.is_action_just_pressed("Fire"):
			check_cooldown()

func check_cooldown():
	if timer.time_left == 0:
		shoot_projectile()
		timer.start()
	else:
		pass

func shoot_projectile():
	if multishot == 1:
		shoot_in_direction(direction)
	else:
		var spread_angle = 45.0
		var angle_step = spread_angle / (multishot - 1)
		for i in range(multishot):
			var angle_offset = (i - (multishot - 1) / 2) * angle_step
			shoot_in_direction(direction.rotated(deg_to_rad(angle_offset)))

func shoot_in_direction(_direction):
	if random_spawn:
		var random_angle = randf_range(-60, 45)
		_direction = _direction.rotated(deg_to_rad(random_angle))
	
	var projectile_instance = projectile_scene.instantiate()
	pass_variables(projectile_instance)
	get_tree().root.add_child(projectile_instance)
	projectile_instance.global_position = spawn.global_position
	projectile_instance.set_direction(_direction)
	projectile_instance.projectile_speed = projectile_speed + get_parent().get_parent().velocity.length()

	# Configuração de velocidade inicial do projétil
	projectile_instance.velocity = _direction * projectile_instance.projectile_speed

func pass_variables(projectile):
	projectile.travelling_time = bullet_decay_time
	projectile.projectile_speed = damage
	projectile.damage = damage

func randomize_timer():
	return randf_range(min_decay, max_decay)

# Aqui, implementamos a lógica de colisão e reflexão se o projétil for bouncy
func _on_collision(collided_with: Node2D, normal: Vector2):
	if bouncy:
		# Refletir a direção com base na colisão
		var bounce_direction = velocity.bounce(normal)  # Usando o método bounce() do Vector2
		velocity = bounce_direction  # Atualiza a direção com a nova refletida
		set_direction(velocity.angle())  # Atualiza a rotação do projétil de acordo com a nova direção
		# O projétil continua se movendo após o "quique"
