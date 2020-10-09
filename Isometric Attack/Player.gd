extends KinematicBody2D

onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")

var max_speed = 400
var speed = 0
var accelaration = 1200
var moving = false
var destination = Vector2()
var movement = Vector2()
var attacking = false

var can_fire = true
var rate_of_fire = 0.4
var shooting = false
var fire_direction

var selected_skill

func _unhandled_input(event):
	if event.is_action_pressed("LMB"):
		moving = true
		destination = get_global_mouse_position()
	elif event.is_action_pressed("RMB"):
		moving = false
		attacking = true
		animation_tree.set('parameters/Melee/blend_position', position.direction_to(get_global_mouse_position()).normalized())
		animation_tree.set('parameters/Idle/blend_position', position.direction_to(get_global_mouse_position()).normalized())
		Attack()
	
func _process(delta):
	SkillLoop()
	
func SkillLoop():
	if Input.is_action_pressed("CMB") and can_fire == true:
		can_fire = false
		shooting = true
		speed = 0
		
		fire_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		
		match selected_skill:
			"Thunder":
				var skill = load("res://RangedSingleTargetSkill.tscn")
				var skill_instance = skill.instance()
				skill_instance.skill_name = selected_skill
				skill_instance.fire_direction = fire_direction
				skill_instance.rotation = get_angle_to(get_global_mouse_position())
				skill_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
				
				get_parent().add_child(skill_instance)
			"Bomb":
				var skill = load("res://RangedAOESkill.tscn")
				var skill_instance = skill.instance()
				skill_instance.skill_name = selected_skill
				skill_instance.position = get_global_mouse_position()
				
				get_parent().add_child(skill_instance)
		
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
		speed = 200

func _physics_process(delta):
	MovementLoop(delta)

func MovementLoop(delta):
	if moving == false:
		speed = 0
	elif shooting == true:
		animation_mode.travel("Idle")
	else:
		speed += accelaration * delta
		if speed > max_speed:
			speed = max_speed
	
		movement = position.direction_to(destination) * speed
		if position.distance_to(destination) > 10:
			movement = move_and_slide(movement)
			animation_tree.set('parameters/Walk/blend_position', movement.normalized())
			animation_tree.set('parameters/Idle/blend_position', movement.normalized())
			animation_mode.travel("Walk")
		else:
			moving = false
			animation_mode.travel("Idle")

func Attack():
	animation_mode.travel("Melee")
	yield(get_tree().create_timer(0.4), "timeout")
	attacking = false
