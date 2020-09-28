extends "res://src/Actors/Actor.gd"

export var score: = 100

func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x

func _physics_process(delta: float):
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
func _on_StompDetector_body_entered(body):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	die()
	
func die() -> void:
	queue_free()
	PlayerData.score += score
