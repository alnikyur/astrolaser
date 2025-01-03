extends Area2D

@export var Fire: PackedScene

@onready var shoot = $Shoot
@onready var laser_empty = $LaserEmpty
@onready var shoot_count = $"../ShootCount"

var max_fire_count = 50
var current_fire_count = max_fire_count
var speed = 10

func _ready():
	$AnimatedSprite2D.play("idle")
	shoot_count.text = "Shots: %d" % max_fire_count

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed
		$AnimatedSprite2D.play("spaceleft")
	else:
		$AnimatedSprite2D.play("idle")
	if Input.is_action_pressed("ui_right"):
		position.x += speed
		$AnimatedSprite2D.play("spaceright")
	if Input.is_action_pressed("ui_up"):
		position.y -=speed
	if Input.is_action_pressed("ui_down"):
		position.y +=speed
	if Input.is_action_just_pressed("ui_select"):  # Предполагается, что 'ui_select' это пробел
		fire()

func fire():
	if current_fire_count > 0:
		current_fire_count -= 1  # Уменьшаем количество выстрелов
		update_shots_label()  # Обновляем интерфейс
		print("Shots left: ", current_fire_count)
		var fire = Fire.instantiate()
		fire.position = position + Vector2(0, -80)
		get_parent().add_child(fire)
		fire.connect("asteroid_destroyed", Callable (self, "add_shots_on_asteroid_destruction"))
		shoot.play()
		var fire_sprite = fire.get_node("AnimatedSprite2D")
		if fire_sprite:
			fire_sprite.play("fire")
	else:
		print("No shots left!")
		laser_empty.play()

func update_shots_label():
	shoot_count.text = "Shots: %d" % current_fire_count

func add_shots_on_asteroid_destruction(amount: int):
	current_fire_count = min(current_fire_count + amount, max_fire_count)  # Добавляем выстрелы, но не превышаем максимум
	update_shots_label()  # Обновляем интерфейс
	print("Shots added: %d, current shots: %d" % [amount, current_fire_count])
