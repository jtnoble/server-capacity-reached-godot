extends TileMap

func pipe():
	pass


func _on_pipes_1_body_entered(body):
	if body.has_method("endPos"):
		print_debug("Destroying pipes")
		queue_free()


func _on_timer_timeout():
	queue_free()
