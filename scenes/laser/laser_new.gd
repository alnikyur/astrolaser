extends Area2D

@export var speed: float = 500
@export var direction: Vector2 = Vector2(0, -1)

@onready var explosion = $Explosion
@onready var explosion_particles = $explosion_particles

signal asteroid_destroyed(amount: int)

func _ready():
	add_to_group("lasers")
	print("Laser added to group 'lasers'. Name: ", name)

func _process(delta):
	position += direction * speed * delta
	
	if position.y < -800 or position.y > 800 or position.x < -700 or position.x > 700:
		queue_free()
		
#func _on_body_entered(body):
	#print("Laser hit: ", body.name)
	#print("Groups: ", body.get_groups())
#
	#if body.is_in_group("asteroids"):
		#print("Laser hit an asteroid in the group 'asteroids'")
#
		#explosion_particles.global_position = body.global_position
		#explosion_particles.emitting = true
		#explosion_particles.visible = true
		#if is_instance_valid(body):
			#body.queue_free()
#
		#var temp_audio = AudioStreamPlayer.new()
		#temp_audio.stream = explosion.stream
		#get_parent().add_child(temp_audio)
		#temp_audio.play()
#
		#temp_audio.connect("finished", Callable(temp_audio, "queue_free"))
#
		#await get_tree().create_timer(0.7).timeout
		#emit_signal("asteroid_destroyed", 3)

		#if is_instance_valid(self):
			#queue_free()











