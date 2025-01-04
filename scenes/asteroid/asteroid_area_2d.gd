extends Area2D

@export var min_speed: float = 10.0
@export var max_speed: float = 50.0

var speed: float
var direction: Vector2

func _ready():
	direction = Vector2(randf_range(-0.5, 0.5), 1).normalized()
	speed = randf_range(min_speed, max_speed)

func _process(delta):

	position += direction * speed * delta

	if position.y > 800:
		queue_free()


func _on_body_entered(body):
	if body:
		print("Collision detected with: ", body.name, " (Type: ", body.get_class(), ")")
		print("Groups: ", body.get_groups())
		print("Collision Layer: ", body.collision_layer, ", Mask: ", body.collision_mask)
		if body.is_in_group("lasers"):
			print("Laser hit asteroid!")
			body.queue_free()
			queue_free()
		else:
			print("Object is not in 'lasers' group.")
	else:
		print("Collision detected, but no body found.")
