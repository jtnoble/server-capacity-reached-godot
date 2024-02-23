extends Label

func _process(delta):
	if Input.is_action_pressed("action"):
		$"..".first_load()
		queue_free()
