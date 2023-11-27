extends Node

@onready var dmgsfx = preload("res://assets/AUDIO/SFX/EnemieHit.wav")
@onready var reflectsfx = preload("res://assets/AUDIO/SFX/Reflect.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func playbgm(music):
	var bgm = load(music)
	$BGM.stream = bgm
	#$BGM.play()
	
#To do, create a function for use the free player node (the one that is not playing music), for avoiding collisions

#Jump MM explosion and damage
func playsfx(sfx):
	$SFX1.stream = sfx
	$SFX1.play()

#shoot and water splash
func playsfx2(sfx):
	$SFX2.stream = sfx
	$SFX2.play()
	
func damagesfx(): #enemie damaged
	$SFX3.stream = dmgsfx
	$SFX3.play()

func reflsfx(): #enemie damaged
	$SFX3.stream = reflectsfx
	$SFX3.play()

func hpfillsfx():
	var sfx = preload("res://assets/AUDIO/SFX/HPFillUp.wav")
	$SFX1.stream = sfx
	$SFX1.play()

func hpsfxstop():
	$SFX1.stop()
