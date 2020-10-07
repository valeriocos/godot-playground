extends KinematicBody2D

const SPEED = 10000
var motion = Vector2()

func cartesian_to_isometric(cartesian):
	var screen_pos = Vector2()
	screen_pos.x = cartesian.x - cartesian.y 
	screen_pos.y = (cartesian.x + cartesian.y) / 2
	return screen_pos
	
func isometric_to_cartesian(iso):
	var cart_pos = Vector2()
	cart_pos.x = (iso.x + iso.y * 2) / 2 
	cart_pos.y = - iso.x + cart_pos.x
	return cart_pos
	
func _physics_process(delta):
	var direction = Vector2()
	
	if Input.is_action_pressed("move_up"):
		direction += Vector2(0, -1)
	elif Input.is_action_pressed("move_down"):
		direction += Vector2(0, 1)

	if Input.is_action_pressed("move_left"):
		direction += Vector2(-1, 0)
	elif Input.is_action_pressed("move_right"):
		direction += Vector2(1, 0)
		
	motion = direction.normalized() * SPEED * delta
	motion = cartesian_to_isometric(motion)
	move_and_slide(motion)

func _ready():
	set_physics_process(true)
