extends RigidBody2D

@export var rotation_speed: float = 1000.0  # Скорость вращения в градусах в секунду
@export var min_speed: float = 200.0  # Минимальная скорость
@export var max_speed: float = 300.0  # Максимальная скорость
@export var min_angle: float = -PI    # Минимальный угол (-180 градусов)
@export var max_angle: float = PI     # Максимальный угол (180 градусов)
@export var min_rotation_speed: float = 0
@export var max_rotation_speed: float = 0
@onready var explosion_particles = $explosion_particles
@onready var explosion = $Explosion

signal asteroid_destroyed(amount: int)

func _ready():
#	connect("body_entered", Callable (self, "_on_body_entered"))
	randomize()
	# Генерируем случайный угол направления
	var angle = randf_range(min_angle, max_angle)
	# Генерируем случайную скорость
	var speed = randf_range(min_speed, max_speed)
	# Вычисляем начальную скорость
	linear_velocity = Vector2(speed, 0).rotated(angle)
	angular_velocity = randf_range(min_rotation_speed, max_rotation_speed)

func _physics_process(delta):
	pass

func _on_body_entered(body):
	print("Collision detected with: ", body.name, " (Type: ", body.get_class(), ")")
	if body.is_in_group("lasers"):
		emit_signal("asteroid_destroyed", 3)
		print("Signal 'asteroid_destroyed' emitted.")
		set_deferred("freeze", true)
		# Перемещаем частицы на место астероида и активируем их
		explosion_particles.global_position = body.global_position  # Устанавливаем позицию частиц
		explosion_particles.emitting = true
		explosion_particles.visible = true
		# Удаляем астероид сразу
		if is_instance_valid(body):
			body.queue_free()

		# Создаём временный узел для звука
		var temp_audio = AudioStreamPlayer.new()
		temp_audio.stream = explosion.stream  # Используем звук взрыва
		get_parent().add_child(temp_audio)  # Добавляем узел в дерево
		temp_audio.play()

		# Удаляем временный узел звука после завершения
		temp_audio.connect("finished", Callable(temp_audio, "queue_free"))

		# Ждём 1 секунду перед удалением лазера
		await get_tree().create_timer(0.7).timeout
		# Удаляем лазер
		if is_instance_valid(self):   
			queue_free()


func set_transparency(alpha: float):
	modulate.a = alpha  # Устанавливаем значение альфа-канала (0.0 = полностью прозрачный, 1.0 = полностью видимый)
