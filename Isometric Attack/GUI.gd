extends CanvasLayer

onready var shortcuts_path = "AttackBar/Background/HBoxContainer/"

var loaded_skills = {
	"Shortcut1": "Bomb",
	"Shortcut2": "Thunder"
}

func _ready():
	LoadShortcuts()
	for shortcut in get_tree().get_nodes_in_group("Shortcuts"):
		shortcut.connect("pressed", self, "SelectShortcut", [shortcut.get_parent().get_name()])

func LoadShortcuts():
	for shortcut in loaded_skills.keys():
		var skill_icon = load("res://assets/" + loaded_skills[shortcut] + "Attack.png")
		get_node(shortcuts_path + shortcut + "/TextureButton").set_normal_texture(skill_icon)

func SelectShortcut(shortcut):
	var skill_icon = load("res://assets/" + loaded_skills[shortcut] + "Attack.png")
	get_node(shortcuts_path + "SelectedAttack/TextureRect").set_texture(skill_icon)
	get_parent().get_node("Player").selected_skill = loaded_skills[shortcut]
