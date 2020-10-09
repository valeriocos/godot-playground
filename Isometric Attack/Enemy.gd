extends KinematicBody2D

onready var animation = $AnimationPlayer
onready var hp_bar = $TextureProgress
onready var hp_bar_tween = hp_bar.get_node("Tween")

const EnemyDeathEffect = preload("res://EnemyDeathEffect.tscn")

var max_hp = 400
var current_hp
var percentage_hp = 100
var can_heal = true
var dead = false

func _ready():
	animation.play("Idle")
	current_hp = max_hp
	
func _process(delta):
	if percentage_hp <= 50 and can_heal == true:
		can_heal = false
		yield(get_tree().create_timer(0.5), "timeout")
		if dead == true:
			pass
		else:
			var skill = load("res://SingleTargetHeal.tscn")
			var skill_instance = skill.instance()
			skill_instance.skill_name = "Heal"
			add_child(skill_instance)
			yield(get_tree().create_timer(1.25), "timeout")
			can_heal = true

func OnHit(damage):
	current_hp -= damage
	HPBarUpdate()
	if current_hp <= 0:
		OnDeath()
		
func OnHeal(heal_amount):
	current_hp += heal_amount
	if current_hp > max_hp:
		current_hp = max_hp
	HPBarUpdate()
		
func HPBarUpdate():
	percentage_hp = int((float(current_hp) / max_hp) * 100)
	hp_bar_tween.interpolate_property(hp_bar, 'value', hp_bar.value, percentage_hp, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	hp_bar_tween.start()
	
	if percentage_hp >= 60:
		hp_bar.set_tint_progress("14e114")
	elif percentage_hp < 60 and percentage_hp >= 40:
		hp_bar.set_tint_progress("e1be32")
	else:
		hp_bar.set_tint_progress("e11e1e")
	
func OnDeath():
	dead = true
	# In case the body of the enemy remains on the field, you need to disable
	# the collision shape to avoid hitting the enemy again and start the death
	# animation over and over
	# get_node("CollisionShape2D").set_deferred("disabled", true)
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	# In case the body of the enemy remains on the field, the HP bar should
	# be hidden 
	hp_bar.hide()
