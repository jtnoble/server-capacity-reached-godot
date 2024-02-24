extends Button

func _on_pressed():
	print_debug("button clicked")
	get_parent().puzzle_completed.emit()
