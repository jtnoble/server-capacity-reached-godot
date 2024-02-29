extends Area2D

@export var speed: float = 1200
var x_spawn: float

func _ready():
	x_spawn = global_position.x

func _process(_delta):
	global_position = Vector2(x_spawn, global_position.y + -speed * _delta)

func _on_body_entered(body):
	if body.has_method("enemy") or body.has_method("OOB"):
		queue_free()
