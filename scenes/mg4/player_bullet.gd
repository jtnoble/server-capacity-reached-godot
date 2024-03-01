extends StaticBody2D

class_name Bullet

@export var player_bullet_speed: float = 800
@export var enemy_bullet_speed: float = -200
var speed: float
var x_spawn: float

func _ready():
	if get_parent().name == "player":
		speed = player_bullet_speed
	else:
		speed = enemy_bullet_speed
	x_spawn = global_position.x

func _process(_delta):
	global_position = Vector2(x_spawn, global_position.y + -speed * _delta)

func _on_body_entered(body):
	if body.has_method("OOB"):
		queue_free()
	if body is Enemy:
		body.death()
		queue_free()

func bullet():
	pass
