extends Node2D

@onready var exp = preload("res://explosion.tscn")
@onready var BUBBLE = preload("res://Bubble.tscn")
@onready var BULLET = preload("res://MegaBuster.tscn")
@onready var megabustersfx = preload("res://assets/AUDIO/SFX/MegaBuster.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func bubble():
	var b = BUBBLE.instantiate()
	get_parent().add_child(b)
	b.position = Global.playerxy + Vector2(0,2)

func shoot(pos):
	var num = get_child_count()
	if num < Global.MM_max_shoot_num:
		Audio.playsfx2(megabustersfx)
		var a = BULLET.instantiate()
		add_child(a)
		a.position = pos

func explosion(pos):
	var b = exp.instantiate()
	get_parent().add_child(b)
	b.position = pos



	
