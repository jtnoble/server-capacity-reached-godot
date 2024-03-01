extends StaticBody2D

class_name Enemy

signal enemy_death()

func _ready():
	$AnimatedSprite2D.play("default")
	
func death():
	$AnimatedSprite2D.play("death")
	pass

func _on_area_2d_body_entered(body):
	if body is Bullet:
		death()

func _on_animated_sprite_2d_animation_finished():
	enemy_death.emit()
	queue_free()
	
func enemy():
	pass



