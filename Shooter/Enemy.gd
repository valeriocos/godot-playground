extends KinematicBody2D

var motion = Vector2()

func _ready():
	pass

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	position += (player.position - position)/50
	look_at(player.position)
	
	move_and_collide(motion)

func _on_Area2D_body_entered(body):
	if "Bullet" in body.name:
		queue_free()
