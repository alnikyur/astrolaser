extends RigidBody2D

@export var speed: float = 500  # Скорость движения лазера
@export var direction: Vector2 = Vector2(0, -1)  # Направление (вверх)
@onready var explosion = $Explosion

signal asteroid_destroyed(amount: int)

func _ready():
	set_deferred("freeze", true)

func _process(delta):
	# Двигаем лазер
	position += direction * speed * delta
	
	# Удаляем лазер, если он выходит за границы экрана
	if position.y < -800 or position.y > 800 or position.x < -700 or position.x > 700:
		queue_free()

#func _on_body_entered(body):
	## Проверяем, является ли столкнувшийся объект астероидом
	#if body.name == "asteroids":  # Или используйте проверку типа объекта, если нужно
		#explosion.play()
		#body.queue_free()  # Удаляем астероид
		#queue_free()  # Удаляем лазер
