extends KinematicBody2D

## Start W, S, D, A
#var max_speed = 400
#var speed = 0
#var accelaration = 1200
#var move_direction = Vector2(0,0)
#
#func _physics_process(delta):
#	MovementLoop(delta)
#
#func _process(delta):
#	AnimationLoop()
#
#func MovementLoop(delta):
#	move_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
#	move_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
#
#	if move_direction == Vector2(0, 0):
#		speed = 0
#	else:
#		speed += accelaration * delta
#		if speed > max_speed:
#			speed = max_speed
#
#		var motion = move_direction.normalized() * speed
#		move_and_slide(motion)
#
#func AnimationLoop():
#	var anim_direction = "S"
#	var anim_mode = "Idle"
#	var animation
#	match move_direction:
#		Vector2(-1, 0):
#			anim_direction = "W"
#		Vector2(1, 0):
#			anim_direction = "E"
#		Vector2(0, 0.5):
#			anim_direction = "S"
#		Vector2(0, -0.5):
#			anim_direction = "N"
#		Vector2(-1, -0.5):
#			anim_direction = "NW"
#		Vector2(-1, 0.5):
#			anim_direction = "SW"
#		Vector2(1, -0.5):
#			anim_direction = "NE"
#		Vector2(1, 0.5):
#			anim_direction = "SE"
#
#	if move_direction != Vector2(0, 0):
#		anim_mode = "Walk"
#	else:
#		anim_mode = "Idle"
#	animation = anim_mode + "_" + anim_direction
#	get_node("AnimationPlayer").play(animation)
## End W,S,A,D

## Start Mouse
#var anim_direction = "S"
#var anim_mode = "Idle"
#var animation
#
#var max_speed = 400
#var speed = 0
#var accelaration = 1200
#var move_direction
#var moving = false
#var destination = Vector2()
#var movement = Vector2()
#
#var attacking = false
#var attack_direction
#
#func _unhandled_input(event):
#	if event.is_action_pressed("LMB"):
#		moving = true
#		destination = get_global_mouse_position()
#	elif event.is_action_pressed("RMB"):
#		moving = false
#		attacking = true
#		attack_direction = rad2deg(get_angle_to(get_global_mouse_position()))
#		Attack()
#
#func _process(delta):
#	AnimationLoop()
#
#func _physics_process(delta):
#	MovementLoop(delta)
#
#func MovementLoop(delta):
#	if moving == false:
#		speed = 0
#	else:
#		speed += accelaration * delta
#		if speed > max_speed:
#			speed = max_speed
#
#	movement = position.direction_to(destination) * speed
#	move_direction = rad2deg(destination.angle_to_point(position))
#	if position.distance_to(destination) > 10:
#		movement = move_and_slide(movement)
#	else:
#		moving = false
#
#func AnimationLoop():
#	if moving:
#		if move_direction <= 15 and move_direction >= -15:
#			anim_direction = "E"
#		elif move_direction <= 60 and move_direction >= 15:
#			anim_direction = "SE"
#		elif move_direction <= 120 and move_direction >= 60:
#			anim_direction = "S"
#		elif move_direction <= 165 and move_direction >= 120:
#			anim_direction = "SW"
#		elif move_direction >= -60 and move_direction <= -15:
#			anim_direction = "NE"
#		elif move_direction >= -120 and move_direction <= -60:
#			anim_direction = "N"
#		elif move_direction >= -165 and move_direction <= -120:
#			anim_direction = "NW"
#		elif move_direction <= -165 and move_direction >= 165:
#			anim_direction = "W"
#
#		if moving == true:
#			anim_mode = "Walk"
#		elif moving == false:
#			anim_mode = "Idle"
#	elif attacking:
#		if attack_direction <= 15 and attack_direction >= -15:
#			anim_direction = "E"
#		elif attack_direction <= 60 and attack_direction >= 15:
#			anim_direction = "SE"
#		elif attack_direction <= 120 and attack_direction >= 60:
#			anim_direction = "S"
#		elif attack_direction <= 165 and attack_direction >= 120:
#			anim_direction = "SW"
#		elif attack_direction >= -60 and attack_direction <= -15:
#			anim_direction = "NE"
#		elif attack_direction >= -120 and attack_direction <= -60:
#			anim_direction = "N"
#		elif attack_direction >= -165 and attack_direction <= -120:
#			anim_direction = "NW"
#		elif attack_direction <= -165 and attack_direction >= 165:
#			anim_direction = "W"
#
#		anim_mode = "Melee"
#
#	animation = anim_mode + "_" + anim_direction
#	get_node("AnimationPlayer").play(animation)
#
#func Attack():
#	yield(get_tree().create_timer(0.4), "timeout")
#	attacking = false
#	anim_mode = "Idle"
## End Mouse

# Start AnimationTree
onready var animation_tree = get_node("AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")

var max_speed = 400
var speed = 0
var accelaration = 1200
var moving = false
var destination = Vector2()
var movement = Vector2()
var attacking = false


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
	pass
	
func _physics_process(delta):
	MovementLoop(delta)

func MovementLoop(delta):
	if moving == false:
		speed = 0
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
# End AnimationTree
