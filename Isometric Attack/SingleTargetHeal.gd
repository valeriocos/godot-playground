extends Node2D

onready var animation = $AnimationPlayer
 
var skill_name
var heal_amount

func _ready():
	heal_amount = DataImport.attack_data[skill_name].heal
	Heal()
	
func Heal():
	animation.play("heal")
	get_parent().OnHeal(heal_amount)
	yield(get_tree().create_timer(1.25), "timeout")
	queue_free()
