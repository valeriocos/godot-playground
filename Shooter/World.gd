extends Node2D

onready var timer = $Timer
const Enemy = preload("res://Enemy.tscn")

func spawn_enemies():
	randomize()
	var num_enemies = int(rand_range(3, 15))
	
	for i in range(0, num_enemies):
		var enemy = Enemy.instance()
		var pos = Vector2(rand_range(0,1024), rand_range(0,1024))
		enemy.set_position(pos)
		add_child(enemy)
		
func _on_Timer_timeout():
	spawn_enemies()
