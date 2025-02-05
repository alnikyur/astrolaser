extends RigidBody2D

@export var min_speed: float = 150.0
@export var max_speed: float = 250.0
@export var min_angle: float = -PI
@export var max_angle: float = PI
@export var min_rotation_speed: float = 5
@export var max_rotation_speed: float = 20
@onready var explosion_particles = $explosion_particles
@onready var explosion = $Explosion

signal asteroid_destroyed(amount: int)
signal asteroid_count(amount: int)

func _ready():
	add_to_group("asteroids")
	randomize()

	var angle = randf_range(min_angle, max_angle)
	var speed = randf_range(min_speed, max_speed)

	linear_velocity = Vector2(speed, 0).rotated(angle)
	angular_velocity = randf_range(min_rotation_speed, max_rotation_speed)


func _physics_process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("lasers"):
		emit_signal("asteroid_destroyed", 3)
		emit_signal("asteroid_count", 1)
		print("Signal 'asteroid_count' emitted.")
		set_deferred("freeze", true)

		explosion_particles.global_position = body.global_position
		explosion_particles.emitting = true
		explosion_particles.visible = true
		if is_instance_valid(body):
			body.queue_free()

		var temp_audio = AudioStreamPlayer.new()
		temp_audio.stream = explosion.stream
		get_parent().add_child(temp_audio)
		temp_audio.play()
		temp_audio.connect("finished", Callable(temp_audio, "queue_free"))

		await get_tree().create_timer(0.7).timeout
		if is_instance_valid(self):
			queue_free()

