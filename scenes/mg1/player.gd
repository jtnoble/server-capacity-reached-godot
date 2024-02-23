extends CharacterBody2D

var speed: float = 100
	
func _physics_process(delta):
	move(delta)
	print_debug(position)
	
func move(delta):
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	move_and_slide()

func _on_goal_body_entered(body):
	print_debug("WIN")
	$"..".win()
