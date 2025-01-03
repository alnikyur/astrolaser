extends RigidBody2D

@export var rotation_speed: float = 1000.0  # Скорость вращения в градусах в секунду
@export var min_speed: float = 200.0  # Минимальная скорость
@export var max_speed: float = 300.0  # Максимальная скорость
@export var min_angle: float = -PI    # Минимальный угол (-180 градусов)
@export var max_angle: float = PI     # Максимальный угол (180 градусов)
@export var min_rotation_speed: float = 0
@export var max_rotation_speed: float = 0
@onready var cpu_particles_2d = $CPUParticles2D

func _ready():
	print("Asteroid is in tree: ", is_inside_tree())
#	connect("body_entered", Callable (self, "_on_body_entered"))
	max_contacts_reported = 10
	randomize()
	# Генерируем случайный угол направления
	var angle = randf_range(min_angle, max_angle)
	# Генерируем случайную скорость
	var speed = randf_range(min_speed, max_speed)
	# Вычисляем начальную скорость
	linear_velocity = Vector2(speed, 0).rotated(angle)
	print("Asteroid velocity: ", linear_velocity)
	angular_velocity = randf_range(min_rotation_speed, max_rotation_speed)

func _physics_process(delta):
	pass

func _on_body_entered(body):
	# Отображаем имя и тип объекта, попавшего в астероид
	if body:
		print("Collision detected with: ", body.name, " (Type: ", body.get_class(), ")")
	else:
		print("Collision detected, but no body found.")
