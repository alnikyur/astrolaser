extends Area2D

@export var Explosion_0: PackedScene
@export var game_manager: NodePath

func _on_body_entered(body):
	if body.is_in_group("asteroids"):
		var explosion_0 = Explosion_0.instantiate()
		add_child(explosion_0)
		explosion_0.global_position = body.global_position

		print("Asteroid hit the bottom!")
		var manager = get_node(game_manager)
		if manager:
			manager.subtract_score(1)
		body.queue_free()
		var animated_sprite = explosion_0.get_node("AnimatedSprite2D") # Замените "AnimationPlayer" на правильный путь в сцене
		#if animated_sprite:
##			animated_sprite.play("explosion_0")
			#animated_sprite.play("explosion_0_backwards")
