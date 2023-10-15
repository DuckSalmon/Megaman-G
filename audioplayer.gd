extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func playbgm(music):
	var bgm = load(music)
	$BGM.stream = bgm
	#$BGM.play()

#Jump MM explosion and damage
func playsfx(sfx):
	$SFX1.stream = sfx
	$SFX1.play()

#shoot and water splash
func playsfx2(sfx):
	$SFX2.stream = sfx
	$SFX2.play()
	
func damagesfx():
	#$SFX2.stream = load("res://assets/AUDIO/SFX/EnemieHit.wav")
	$SFX3.play()
