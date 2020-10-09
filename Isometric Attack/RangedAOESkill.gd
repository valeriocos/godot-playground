extends Area2D

onready var animation_player = $AnimationPlayer

var skill_name
var fire_direction
var damage = 180
var animation = "explosion"
var damage_delay_time = 0.3
var remove_delay_time = 1.1

func _ready():
	AOEAttack()
	
func AOEAttack():
	animation_player.play(animation)
	yield(get_tree().create_timer(damage_delay_time), "timeout")
	var targets = get_overlapping_bodies()
	for target in targets:
		target.OnHit(damage)
	yield(get_tree().create_timer(remove_delay_time), "timeout")
	self.queue_free()

