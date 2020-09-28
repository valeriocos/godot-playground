extends Node

signal score_updated
signal player_died


var score: = 0 setget set_score
var deaths: = 0 setget set_deaths

func reset() -> void:
	score = 0
	deaths = 0

func set_score(value: int) -> void:
	score = value
	emit_signal("score_updated")
	
func set_deaths(value: int) -> void:
	deaths = value
	emit_signal("player_died")
