extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D

var speed = 20
var player_chase = false
var player = null

func _physics_process(delta):
	_animated_sprite.play("idle")
	if player_chase:
		velocity = (player.get_global_position() - position).normalized() * speed * delta
	else:
		velocity = Vector2(0,0)
	move_and_collide(velocity)



func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	
func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
