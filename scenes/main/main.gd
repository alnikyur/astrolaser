extends Node2D

@export var Asteroid: PackedScene
@export var AsteroidGray: PackedScene
@export var spawn_interval: float = 1
@export var screen_width: int = 600
@export var screen_height: int = 800
@export var asteroid_count: int = 1
@export var asteroid_gray_count: int = 1

@onready var description = $Description
@onready var fade_in_out = $FadeInOut


var score: int = 10

func _ready():
	randomize()
	$Timer.wait_time = spawn_interval
	$Timer.start()

	fade_text_in()
	await get_tree().create_timer(5.0).timeout
	fade_text_out()

func subtract_score(amount: int):
	score -= amount
	print("Score decreased! Current score: ", score)
	if score <= 0:
		game_over()

func game_over():
	print("Game Over!")

func _on_timer_timeout():
	for i in range(asteroid_count):
		var asteroid = Asteroid.instantiate()
		add_child(asteroid)
		
		var x_position = randf_range(-600, screen_width)
		var y_position = -800
		asteroid.position = Vector2(x_position, y_position)
		
	for i in range(asteroid_gray_count):
		var asteroid_gray = AsteroidGray.instantiate()
		add_child(asteroid_gray)
		
		var x_position = randf_range(-600, screen_width)
		var y_position = -800
		asteroid_gray.position = Vector2(x_position, y_position)


func _on_asteroid_catcher_body_entered(body):
	if body:
		print("ASTEROID DETECTED: ", body.name, " (Type: ", body.get_class(), ")")
		print("Groups: ", body.get_groups())

		if body.is_in_group("asteroids"):
			print("Asteroid caught and removed!")
			body.queue_free()
		else:
			print("Object is not an asteroid.")
	else:
		print("Collision detected, but no body found.")

func fade_text_in():
	fade_in_out.play("fadein")

func fade_text_out():
	fade_in_out.play("fadeout")
