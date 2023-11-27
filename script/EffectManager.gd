extends Node2D

@onready var exp = preload("res://explosion.tscn")
@onready var BUBBLE = preload("res://Bubble.tscn")
@onready var BULLET = preload("res://MegaBuster.tscn")
@onready var megabustersfx = preload("res://assets/AUDIO/SFX/MegaBuster.wav")
@onready var miniene = preload("res://energy_lt.tscn")
@onready var miniwep = preload("res://WPNEnergy.tscn")
@onready var bigene = preload("res://energy_big.tscn")
@onready var bigwep = preload("res://WPNEnergyBig.tscn")


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
	var randomnum = randi() %127 #ENEMIE DROP SYSTEM, generate number from 0 to 127 
	print(randomnum)
	if randomnum == 0:
		print("1 up spawn WIP")
	elif randomnum >= 1 and randomnum <= 25: #drop mini weapon energy
		var a = miniwep.instantiate()
		get_parent().add_child(a)
		a.position = pos
		a.timer()
	elif randomnum >= 26 and randomnum <= 40: #drop mini energy
		var a = miniene.instantiate()
		get_parent().add_child(a)
		a.position = pos
		a.timer()
	elif randomnum >= 41 and randomnum <= 44: #drop big energy
		var a = bigene.instantiate()
		get_parent().add_child(a)
		a.position = pos
		a.timer()
	elif randomnum >= 45 and randomnum <= 49: #drop big weapon energy
		var a = bigwep.instantiate()
		get_parent().add_child(a)
		a.position = pos
		a.timer()
	else:
		print("nothing")
		
		


func heal(health):
	Global.playerHP += health
	if Global.playerHP > 28:
		Global.playerHP = 28
		#for number in range (remainpoint):
			#print(remainpoint)
			#remainpoint -= 1
			#Global.playerHP += 1
			#Audio.hpfillsfx()
			#$Timer.start()
			#get_tree().paused = true
			#
		#if remainpoint == 0:
			#Audio.hpsfxstop()
	#else:
		#pass
#
#func _on_timer_timeout():
	#get_tree().paused = false
