extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invicible = false setget set_invicible

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

signal invicibility_started
signal invicibility_ended

func set_invicible(value):
	invicible = value
	if invicible == true:
		emit_signal("invicibility_started")
	else:
		emit_signal("invicibility_ended")

func start_invicibility(duration):
	self.invicible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position 

func _on_Timer_timeout():
	self.invicible = false

func _on_Hurtbox_invicibility_started():
	collisionShape.set_deferred("disable", true)

func _on_Hurtbox_invicibility_ended():
	collisionShape.disabled = false
