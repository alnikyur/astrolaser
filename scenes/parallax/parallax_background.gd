#extends ParallaxBackground
#
#@export var scroll_speed: Vector2 = Vector2(0,  50)
#@export var infinite_scroll: bool = true
#
#func _process(delta):
	#scroll_offset += scroll_speed * delta


extends ParallaxBackground

@export var speed: Vector2 = Vector2(0, 50)  # Скорость движения фона (в пикселях/сек)

var manual_scroll_offset: Vector2 = Vector2.ZERO

func _process(delta):
	# Добавляем автоматическое смещение
	manual_scroll_offset += speed * delta
	scroll_offset = manual_scroll_offset
