extends RigidBody2D

@export var speed: float = 500 
@export var direction: Vector2 = Vector2(0, -1)
@onready var explosion = $Explosion

signal asteroid_destroyed(amount: int)

func _ready():
	set_deferred("freeze", true)

func _process(delta):
	position += direction * speed * delta
	
	if position.y < -800 or position.y > 800 or position.x < -700 or position.x > 700:
		queue_free()

func _exit_tree():
	remove_from_group("lasers")
