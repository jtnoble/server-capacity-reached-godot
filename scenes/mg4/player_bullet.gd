extends StaticBody2D

class_name Bullet

@export var player_bullet_speed: float = 800
@export var enemy_bullet_speed: float = -150
var speed: float
var x_spawn: float
var parent

func _ready():
	parent = get_parent()
	if parent is Player:
		speed = player_bullet_speed
		$PlayerBullet.play()
	else:
		speed = enemy_bullet_speed
		$EnemyBullet.play()
	x_spawn = global_position.x

func _process(_delta):
	global_position = Vector2(x_spawn, global_position.y + -speed * _delta)

func _on_body_entered(body):
	if body.has_method("OOB"):
		queue_free()
	if parent is Player and body is Enemy:
		body.death()
		queue_free()
	elif parent is Enemy and body is Player:
		body.death()
		queue_free()

func bullet():
	pass
