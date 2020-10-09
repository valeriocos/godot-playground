extends CanvasLayer

onready var shortcuts_path = "AttackBar/Background/HBoxContainer/"

var default_skill = "Shortcut2"
var loaded_skills = {
	"Shortcut1": "Bomb",
	"Shortcut2": "Thunder",
	"Shortcut3": "Shockwave"
}

func _ready():
	LoadShortcuts()
	InitSkill()
	for shortcut in get_tree().get_nodes_in_group("Shortcuts"):
		shortcut.connect("pressed", self, "SelectShortcut", [shortcut.get_parent().get_name()])

func InitSkill():
	if get_node(shortcuts_path + "SelectedAttack/TextureRect").texture == null:
		var skill_icon = load("res://assets/ThunderAttack.png")
		get_node(shortcuts_path + "SelectedAttack/TextureRect").set_texture(skill_icon)
		get_parent().get_node("Player").selected_skill = loaded_skills[default_skill]

func LoadShortcuts():
	for shortcut in loaded_skills.keys():
		var skill_icon = load("res://assets/" + loaded_skills[shortcut] + "Attack.png")
		get_node(shortcuts_path + shortcut + "/TextureButton").set_normal_texture(skill_icon)

func SelectShortcut(shortcut):
	var skill_icon = load("res://assets/" + loaded_skills[shortcut] + "Attack.png")
	get_node(shortcuts_path + "SelectedAttack/TextureRect").set_texture(skill_icon)
	get_parent().get_node("Player").selected_skill = loaded_skills[shortcut]
