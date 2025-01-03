extends Area2D

@export var game_manager: NodePath  # Путь к узлу GameManager

func _on_body_entered(body):
	if body.is_in_group("asteroids"):
		print("Asteroid hit the bottom!")
		var manager = get_node(game_manager)
		if manager:
			manager.subtract_score(1)  # Уменьшаем очки на 1
		body.queue_free()  # Удаляем астероид
