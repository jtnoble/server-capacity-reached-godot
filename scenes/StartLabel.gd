extends Label

func _process(delta):
	var input = Input.get("action")
	print_debug(input)
	if Input.get("action"):
		$"..".first_load()
		queue_free()
