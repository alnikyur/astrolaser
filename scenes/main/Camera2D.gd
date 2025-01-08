extends Camera2D

func shake(intensity: float, duration: float) -> void:
	var original_position = position

	# Создаём временный таймер
	var timer = Timer.new()
	timer.wait_time = 0.05  # Интервал между смещениями
	timer.one_shot = false
	add_child(timer)  # Добавляем таймер в дерево
	timer.start()

	while duration > 0:
		duration -= timer.wait_time
		position = original_position + Vector2(
			randf_range(-intensity, intensity),
			randf_range(-intensity, intensity)
		)
		await timer.timeout  # Ждём следующего срабатывания таймера

	# Возвращаем камеру в исходное положение и удаляем таймер
	position = original_position
	timer.queue_free()
