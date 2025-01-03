extends Node2D

@export var Asteroid: PackedScene
@export var spawn_interval: float = 1  # Интервал спавна
@export var screen_width: int = 600  # Ширина экрана
@export var screen_height: int = 800  # Высота экрана
@export var asteroid_count: int = 1  # Количество астероидов

func _ready():
	randomize()
	$Timer.wait_time = spawn_interval
	$Timer.start()

func _on_timer_timeout():
	for i in range(asteroid_count):
		var asteroid = Asteroid.instantiate()
		add_child(asteroid)
		
		# Случайное распределение по ширине экрана
		var x_position = randf_range(-600, screen_width)
		var y_position = -800  # Чтобы астероиды появлялись чуть выше экрана
		asteroid.position = Vector2(x_position, y_position)
		
		# Если ваш астероид — это RigidBody2D
		#if asteroid is RigidBody2D:
			#asteroid.linear_velocity = Vector2(0, randf_range(100, 200))  # Скорость движения вниз

#		print("Asteroid spawned at position: ", asteroid.position)
