extends AnimatedSprite2D

@onready var animated_sprite_2d = $"."


func _ready():
	animated_sprite_2d.play("explosion_0")
	animated_sprite_2d.play("explosion_0_backwards")
	$DeletionTimer.start()
	$AudioStreamPlayer2D.play()


func _process(delta):
	pass


func _on_deletion_timer_timeout():
	queue_free()
