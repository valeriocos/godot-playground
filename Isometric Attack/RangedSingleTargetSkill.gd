extends RigidBody2D

onready var animation = $AnimationPlayer

var skill_name
var fire_direction
var projectile_speed = 400
var life_time = 3
var damage = 90

func _ready():
	var direction = Vector2(projectile_speed, 0).rotated(rotation)
	apply_impulse(Vector2(), direction)
	animation.play("Fire")

func SelfDestruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()

func _on_Spell_body_entered(body):
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	if body.is_in_group("Enemies"):
		body.OnHit(damage)
	self.hide()
