extends CharacterBody2D

var up_force: float = -10000
var move_speed: float = 250
var gravity: float = 10000

func _physics_process(delta):
	velocity.x = move_speed
	velocity.y = gravity * delta
	if Input.is_action_just_pressed("action"):
		# Because there is no floor check, we cannot just set velocity.y to something else
		#   since gravity will immediately take over afterwards.
		#   We need something like `if not jumping, apply gravity. else, do not apply gravity
		pass
	move_and_slide()
