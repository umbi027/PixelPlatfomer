extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const JUMP_FORCE = 128

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var coinValText = get_tree().get_root().get_node("World/Control/CoinGained")

var motion = Vector2.ZERO
var coinCollted = 0


func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if x_input != 0:
		animation_player.play("Run")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animation_player.play("Stand")

	motion.y += GRAVITY * delta

	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		animation_player.play("Jump")

		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2.0:
			motion.y = -JUMP_FORCE/2.0


		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)


	
	motion = move_and_slide(motion, Vector2.UP)

func add_coin():
	coinCollted += 1
	coinValText.text = str(coinCollted)
