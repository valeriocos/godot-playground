extends Area2D

export var score: = 100

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_body_entered(body):
	picked()
	
func picked() -> void:
	PlayerData.score += score
	anim_player.play("fade_out")
