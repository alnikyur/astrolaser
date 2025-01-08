extends CharacterBody2D

@export var Fire: PackedScene

@onready var shoot = $Shoot
@onready var laser_empty = $LaserEmpty
@onready var shoot_count = $"../ShootCount"
@onready var score = $"../Score"

@export var acceleration: float = 600.0
@export var max_speed: float = 500.0
@export var friction: float = 600.0

@export var max_health: int = 100  # Максимальное здоровье
@export var health_bar_path: NodePath  # Путь к шкале здоровья
var current_health: int = max_health  # Текущее здоровье



var max_fire_count = 100
var current_fire_count = max_fire_count
var current_score_count = 0

func _ready():
	$AnimatedSprite2D.play("idle")
	get_tree().connect("node_added", Callable(self, "_on_node_added"))
	var health_bar = get_node_or_null(health_bar_path)
	if health_bar:
		health_bar.value = current_health

func _on_node_added(node):
	if node.is_in_group("asteroids"):
		node.connect("asteroid_destroyed", Callable(self, "add_shots_on_asteroid_destruction"))
		node.connect("asteroid_count", Callable(self, "add_score_count"))


func _process(delta):
	var input_direction = Vector2.ZERO

	# Keyboard input support
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

	# Joystick input support
	var joystick_direction = Vector2(
		Input.get_joy_axis(0, JOY_AXIS_LEFT_X),
		Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
	)

	input_direction += joystick_direction
	input_direction = input_direction.normalized()

	velocity += input_direction * acceleration * delta
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	if input_direction == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()

	if Input.is_action_just_pressed("ui_select") or Input.is_action_just_pressed("joy_fire"):
		fire()


func fire():
	if current_fire_count > 0:
		var num_lasers = 1
		if current_score_count >= 50:
			num_lasers = 3
		elif current_score_count >= 20:
			num_lasers = 2

		current_fire_count -= num_lasers
		update_shots_label()

		print("Shots left: ", current_fire_count)

		if num_lasers == 1 or num_lasers == 3:
			var center_fire = Fire.instantiate()
			center_fire.position = position + Vector2(0, -80)
			get_parent().add_child(center_fire)

		if num_lasers >= 2:
			var left_fire = Fire.instantiate()
			left_fire.position = position + Vector2(-20, -80)
			get_parent().add_child(left_fire)

		if num_lasers >= 2:
			var right_fire = Fire.instantiate()
			right_fire.position = position + Vector2(20, -80)
			get_parent().add_child(right_fire)

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

func increase_health(amount: int):
	# Увеличиваем здоровье, но не превышаем max_health
	current_health = clamp(current_health + amount, 0, max_health)

	# Обновляем шкалу здоровья
	var health_bar = get_node_or_null(health_bar_path)
	if health_bar:
		health_bar.value = current_health
		print("Health bar updated to: ", current_health)

func _on_area_2d_body_entered(body):
	print("Entered body: ", body.name)
	if body.is_in_group("health"):  # Проверяем, принадлежит ли объект группе health_points
		body.queue_free()  # Удаляем health_point
		restore_health()

func restore_health():
	current_health = max_health  # Полностью восстанавливаем здоровье
	update_health_bar()
	var asteroid_catcher = get_parent().get_node("AsteroidCatcher")  # Укажите правильный путь
	if asteroid_catcher:
		asteroid_catcher.sync_health()


func update_health_bar():
	# Обновляем шкалу здоровья
	var health_bar = get_node_or_null(health_bar_path)
	if health_bar:
		health_bar.value = current_health
		print("Health bar updated to: ", current_health)
