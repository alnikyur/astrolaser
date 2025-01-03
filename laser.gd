extends RigidBody2D

var speed = 400  # Скорость пули
var direction = Vector2(0, -1) # Направление движения пули вверх

func _ready():
	animation_fire()
	add_to_group("bullets")
	gravity_scale = 0
	# Задаем начальное направление и скорость пули
	linear_velocity = direction.normalized() * speed

	# Устанавливаем таймер для удаления пули через некоторое время
	var timer = Timer.new()
	timer.wait_time = 3  # Продолжительность жизни пули в секундах
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))  # Используем Callable для подключения сигнала
	add_child(timer)
	timer.start()

func _on_body_entered(body):
	queue_free()  # Удаляем пулю при столкновении

func _on_Timer_timeout():
	queue_free()  # Удаляем пулю

func animation_fire():
	$AnimatedSprite2D.play("fire")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.frame = 5

