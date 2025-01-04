extends CharacterBody2D

@export var Fire: PackedScene

@onready var shoot = $Shoot
@onready var laser_empty = $LaserEmpty
@onready var shoot_count = $"../ShootCount"
@onready var score = $"../Score"


@export var acceleration: float = 600.0
@export var max_speed: float = 500.0
@export var friction: float = 600.0

var max_fire_count = 50
var current_fire_count = max_fire_count
var current_score_count = 0

func _ready():
	$AnimatedSprite2D.play("idle")
	get_tree().connect("node_added", Callable(self, "_on_node_added"))

func _on_node_added(node):
	if node.is_in_group("asteroids"):
		node.connect("asteroid_destroyed", Callable(self, "add_shots_on_asteroid_destruction"))
		node.connect("asteroid_count", Callable(self, "add_score_count"))
		print("Connected asteroid: ", node.name)

func _process(delta):
	var input_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
		$AnimatedSprite2D.play("spaceleft")
	elif Input.is_action_pressed("ui_right"):
		input_direction.x += 1
		$AnimatedSprite2D.play("spaceright")
	else:
		$AnimatedSprite2D.play("idle")

	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1

	input_direction = input_direction.normalized()
	velocity += input_direction * acceleration * delta
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	if input_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()

	if Input.is_action_just_pressed("ui_select"):
		fire()

func fire():
	if current_fire_count > 0:
		current_fire_count -= 1
		update_shots_label()
		print("Shots left: ", current_fire_count)
		var fire = Fire.instantiate()
		fire.position = position + Vector2(0, -80)
		get_parent().add_child(fire)
		shoot.play()
	else:
		print("No shots left!")
		laser_empty.play()

func update_shots_label():
	shoot_count.text = "Shots: %d" % current_fire_count

func update_score_label():
	score.text = "Score: %d" % current_score_count

func add_shots_on_asteroid_destruction(amount: int):
	current_fire_count = min(current_fire_count + amount, max_fire_count)
	update_shots_label()
	print("Shots added: %d, current shots: %d" % [amount, current_fire_count])

func add_score_count(amount: int):
	current_score_count += amount
	update_score_label()
	print("Score added: %d, current score: %d" % [amount, current_score_count])
