extends ParallaxBackground

@export var scroll_speed: Vector2 = Vector2(0,  50)  # Скорость прокрутки (x, y)
@export var infinite_scroll: bool = true  # Для бесконечного прокручивания

func _process(delta):
	# Прокрутка фона
	scroll_offset += scroll_speed * delta
