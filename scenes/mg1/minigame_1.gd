extends Node2D

@onready var player = $player
func _ready():
	$Timer.start()
	player.position = Vector2(268, 770)
	
func win():
	$"..".next_game()
	queue_free()

func lose():
	pass

func _on_timer_timeout():
	lose()

func _physics_process(delta):
	var time_left = $Timer.time_left
	var text_string = "%d"
	$TimerLabel.text = text_string % time_left
