extends Area2D

@export var speed: float = 500  # Скорость движения лазера
@export var direction: Vector2 = Vector2(0, -1)  # Направление (вверх)

@onready var explosion = $Explosion
@onready var explosion_particles = $explosion_particles

signal asteroid_destroyed(amount: int)

func _ready():
	add_to_group("lasers")
	print("Laser added to group 'lasers'. Name: ", name)

func _process(delta):
	# Двигаем лазер
	position += direction * speed * delta
	
	# Удаляем лазер, если он выходит за границы экрана
	if position.y < -800 or position.y > 800 or position.x < -700 or position.x > 700:
		queue_free()
		
#func _on_body_entered(body):
	#print("Laser hit: ", body.name)
	#print("Groups: ", body.get_groups())
#
	#if body.is_in_group("asteroids"):
		#print("Laser hit an asteroid in the group 'asteroids'")
#
		## Перемещаем частицы на место астероида и активируем их
		#explosion_particles.global_position = body.global_position  # Устанавливаем позицию частиц
		#explosion_particles.emitting = true
		#explosion_particles.visible = true
		## Удаляем астероид сразу
		#if is_instance_valid(body):
			#body.queue_free()
#
		## Создаём временный узел для звука
		#var temp_audio = AudioStreamPlayer.new()
		#temp_audio.stream = explosion.stream  # Используем звук взрыва
		#get_parent().add_child(temp_audio)  # Добавляем узел в дерево
		#temp_audio.play()
#
		## Удаляем временный узел звука после завершения
		#temp_audio.connect("finished", Callable(temp_audio, "queue_free"))
#
		## Ждём 1 секунду перед удалением лазера
		#await get_tree().create_timer(0.7).timeout
		#emit_signal("asteroid_destroyed", 3)
		## Удаляем лазер
		#if is_instance_valid(self):
			#queue_free()











