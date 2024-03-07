extends Area2D

var move_side_amount: float = 35
var move_down_amount: float = 75
var move_count: int = 0
var move_limit: int = 9
var move_left: bool = false
var enemies: Array = []
var enemy_count: int = 0
var rng

func _ready():
	rng = RandomNumberGenerator.new()
	var i = 0
	for child in get_children():
		if child is Enemy:
			child.index = i
			i += 1
			child.connect("enemy_death", _on_enemy_death_emit)
			enemies.append(child)
	enemy_count = enemies.size()

func move():
	if move_count < move_limit:
		if move_left:
			position.x -= move_side_amount
		else:
			position.x += move_side_amount
		move_count += 1
	else:
		move_count = 0
		position.y += move_down_amount
		move_left = !move_left

func random_enemy_shoot():
	var num = rng.randi_range(0, enemy_count - 1)
	if enemies[num] != null:
		enemies[num].shoot()

func _on_enemy_death_emit(index):
	enemies[index] = null
	enemy_count -= 1
	if enemy_count <= 0:
		get_parent().minigame_completed.emit()
	
func _on_timer_timeout():
	move()
	$MoveTimer.start()


func _on_shoot_timer_timeout():
	random_enemy_shoot()
	$ShootTimer.start()
