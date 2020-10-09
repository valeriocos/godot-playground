extends Node

var attack_data

func _ready():
	var attack_data_file = File.new()
	attack_data_file.open("res://data/attacks.json", File.READ)
	var attack_data_json = JSON.parse(attack_data_file.get_as_text())
	attack_data_file.close()
	attack_data = attack_data_json.result
