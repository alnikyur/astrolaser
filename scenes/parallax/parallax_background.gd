extends ParallaxBackground

@export var scroll_speed: Vector2 = Vector2(0,  50)
@export var infinite_scroll: bool = true

func _process(delta):
	scroll_offset += scroll_speed * delta
