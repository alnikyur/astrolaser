extends Area2D

@export var Explosion_0: PackedScene
@export var game_manager: NodePath
@export var pause_menu_path: NodePath
@export var max_health: int = 100
@export var health_bar_path: NodePath
@export var camera_path: NodePath
@export var player_path: NodePath

var current_health: int = max_health
var is_paused = false

func _ready():
	var health_bar = get_node_or_null(health_bar_path)
	if health_bar:
		print("Health bar found: ", health_bar)
		health_bar.value = current_health  # Инициализируем шкалу здоровья
	else:
		print("Health bar not found at path: ", health_bar_path)
	
func sync_health():
	# Получаем обновлённое здоровье от игрока
	var player = get_node_or_null(player_path)
	if player:
		current_health = player.current_health
		update_health_bar()

func take_damage(amount: int):
	current_health -= amount
	current_health = clamp(current_health, 0, max_health)  # Убедимся, что здоровье не меньше 0
	update_health_bar()

	# Проверяем, если здоровье закончилось
	if current_health <= 0:
		on_death()

func update_health_bar():
	# Обновляем шкалу здоровья
	var health_bar = get_node_or_null(health_bar_path)
	if health_bar:
		health_bar.value = current_health
		print("Health bar updated to: ", current_health)

func on_death():
	print("Game Over!")
	var pause_menu = get_node(pause_menu_path)
	if pause_menu:
		is_paused = !is_paused
		get_tree().paused = is_paused
		pause_menu.visible = is_paused
		$"../CanvasLayer/Label".visible = true

func _on_body_entered(body):
	if body.is_in_group("asteroids"):
		var explosion_0 = Explosion_0.instantiate()
		add_child(explosion_0)
		explosion_0.global_position = body.global_position

		print("Asteroid hit the bottom!")
		var manager = get_node(game_manager)
		if manager:
			manager.subtract_score(1)
		take_damage(10)
		$"../Camera2D".shake(20, 0.5)
		body.queue_free()
		var animated_sprite = explosion_0.get_node("AnimatedSprite2D") # Замените "AnimationPlayer" на правильный путь в сцене	
