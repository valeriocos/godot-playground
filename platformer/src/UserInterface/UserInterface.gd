extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var score: Label = get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/Title")

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	update_interface()

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and pause_title.text != "You died":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	score.text = "Score: %s" % PlayerData.score

func _on_PlayerData_player_died() -> void:
	self.paused = true
	pause_title.text = "You died"
