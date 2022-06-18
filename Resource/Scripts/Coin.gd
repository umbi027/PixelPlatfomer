extends Area2D

onready var anim = $AnimationPlayer


func _ready():
	anim.play("Spin")



func _on_Coin_body_entered(body):
	queue_free()
	body.add_coin()
