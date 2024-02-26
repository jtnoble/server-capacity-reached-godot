extends RigidBody2D

@export var up_force: float = -1200
var first_move: bool = true

func _ready():
	set_deferred("lock_rotation", true)
	set_deferred("freeze", true)

func _physics_process(delta):
	if Input.is_action_just_pressed("action"):
		if first_move:
			first_move = false
			freeze = false
		linear_velocity = Vector2.ZERO
		apply_central_impulse(Vector2(0, up_force))


func _on_area_2d_body_entered(body):
	print_debug(body)
	if body.has_method("pipe") or body.has_method("OOB"):
		$"..".restart()

