extends StaticBody2D

class_name Enemy

var bullet = preload("res://scenes/mg4/player_bullet.tscn")
var index = 0

signal enemy_death()
	
func _ready():
	$AnimatedSprite2D.play("default")
	
func shoot():
	var new_bullet = bullet.instantiate()
	add_child(new_bullet)
		
func death():
	$DeathSound.play()
	$AnimatedSprite2D.play("death")
	pass

func _on_area_2d_body_entered(body):
	if body.get_parent() is Player and body is Bullet:
		death()

func _on_animated_sprite_2d_animation_finished():
	enemy_death.emit(index)
	queue_free()
	
func enemy():
	pass



