extends RigidBody2D

@export var min_speed: float = 150.0
@export var max_speed: float = 200.0
@export var min_angle: float = -PI
@export var max_angle: float = PI
@export var min_rotation_speed: float = 5
@export var max_rotation_speed: float = 10

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
	print("ENTERED BODY: ", body.name)
	if body.is_in_group("spaceship"):
		queue_free()
