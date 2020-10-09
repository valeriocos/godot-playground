extends Node2D


onready var animation = $AnimationPlayer
 
func _ready():
	animation.play("Death")
	yield(get_tree().create_timer(1), "timeout")
	queue_free()
