extends CharacterBody2D

const SPEED = 100
const SPRINT_MULT = 1.5

const MAX_HP = 100
const MAX_STAM = 100

var HP = 100
var STAM = 100
var cooldown = false
var damage = 40

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _progress_bar = $TextureProgressBar
@onready var _range = $Area2D/CollisionShape2D

func _physics_process(delta):
	_progress_bar.value = STAM
	_progress_bar.visible = !STAM == 100
	_attack(delta)
	_anim_move(delta)
	_anim_turn(delta)
	
	var direction := Vector2.ZERO
	if (STAM <= MAX_STAM) and !Input.is_action_pressed("ui_sprint"):
		STAM += 0.25;
		if (STAM > MAX_STAM):
			STAM = MAX_STAM
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_sprint") and (STAM > 0):
		velocity = direction.normalized() * SPEED * SPRINT_MULT
		STAM -= 0.5
	else:
		velocity = direction.normalized() * SPEED
	
	move_and_slide()

func _attack(_delta):
	if ((Input.is_action_pressed("click") == true) and (cooldown == false)):
		_range.disabled = false
		cooldown = true
		await get_tree().create_timer(0.2).timeout
		_range.disabled = true
		await get_tree().create_timer(0.5).timeout
		cooldown = false

func _on_detection_area_body_entered(body):
	if (body is Enemy):
		body.hp -= damage
	

func _anim_move(_delta):
	if (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		_animated_sprite.play("run")
	else:
		_animated_sprite.stop()
		
func _anim_turn(_delta):
	if (Input.is_action_pressed("ui_left")):
		if (!_animated_sprite.is_flipped_h()):
			_animated_sprite.set_flip_h(!_animated_sprite.is_flipped_h())
	if (Input.is_action_pressed("ui_right")):
		if (_animated_sprite.is_flipped_h()):
			_animated_sprite.set_flip_h(!_animated_sprite.is_flipped_h())
	
		


		
	
