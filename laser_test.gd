extends RigidBody2D

@onready var explosion = $Explosion

func _ready():
	pass

func _on_body_entered(body):
	# Проверяем, является ли столкнувшийся объект астероидом
	if body.name == "asteroids":  # Или используйте проверку типа объекта, если нужно
		explosion.play()
		body.queue_free()  # Удаляем астероид
		queue_free()  # Удаляем лазер
