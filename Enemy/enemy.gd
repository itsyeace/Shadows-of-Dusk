extends CharacterBody2D

@export var movement_speed = 20.0
@export var hp = 10

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer
@onready var nav : NavigationAgent2D = $NavigationAgent2D

func _ready():
	anim.play("walk")

func _physics_process(delta):
	var direction = Vector2()
	
	nav.target_position = player.global_position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = direction*movement_speed
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false


func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
