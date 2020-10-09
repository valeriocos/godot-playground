extends Area2D

onready var animation = $AnimationPlayer

var skill_name
var damage
var radius = 150
var life_time = 1
var damaged_targets = []

var circle_shape = preload("res://resources/CircleShape.tres")

func _ready():
	damage = DataImport.attack_data[skill_name].damage
	AOEAttack()

func AOEAttack():
	animation.play("expansion")
	var radius_step = radius / (life_time / 0.05)
	while get_node("CollisionShape2D").get_shape().radius <= radius:
		var shape = circle_shape.duplicate()
		shape.set_radius(get_node("CollisionShape2D").get_shape().radius + radius_step)
		get_node("CollisionShape2D").set_shape(shape)
		
		var targets = get_overlapping_bodies()
		for target in targets:
			if damaged_targets.has(target):
				continue
			else:
				if target.is_in_group("Enemies"):
					target.OnHit(damage)
					damaged_targets.append(target)
		
		yield(get_tree().create_timer(0.05), "timeout")
		continue
	queue_free()
