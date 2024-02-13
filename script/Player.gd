extends CharacterBody2D

@export var projectile = PackedScene

var state

var WALK_SPEED := 82.5
var JUMP_SPEED = 285.0
var MAX_FALL_SPEED := 420.0

var direction := 1
var is_rising := false

var is_sliding := false
var under_water := false
var is_taking_damage := false
var is_invincible := false

@onready var attacktimer = $Shootanimtimer
@onready var defeatsfx = preload("res://assets/AUDIO/SFX/MegamanDefeat.wav")
@onready var splashsfx = preload("res://assets/AUDIO/SFX/splash.wav")
@onready var damagesfx = preload("res://assets/AUDIO/SFX/MMdamage.wav")

func _ready():
	$HitSprite.hide()
	add_child(state)
	$State.change_state("Onair")
	
func _physics_process(delta):
	Global.playerxy = self.global_position
	$Label.text = str($State.current_state.name)

	if direction == -1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
#Animations
 #Replace all with a state machine
	
	#if is_taking_damage == true:
		#$Sprite/AnimationPlayer.play("damage")

#Actions:

	#Slide WIP
	if Input.is_action_pressed("jump") and Input.is_action_pressed("down"):
		is_sliding = true
		print("slide")
		$SlidingTimer.start()
		
	
			
			
	
	if Global.playerHP <= 0:
		death()
	
	move_and_slide()

#shoot
	


func _on_pit_ops():
	death()
	

func _on_area_2d_body_entered(body):
	splash()
	under_water = true
	$Bubble.start()
	

func _on_area_2d_body_exited(body):
	splash()
	under_water = false
	
func splash():
	Audio.playsfx2(splashsfx)
	print("splasgh")
	
	#Death anim and explosions + scene reload
func death():
	$State.change_state("Dead")
	is_invincible = true
	$Sprite.hide()
	Audio.playsfx2(defeatsfx)
	var piupiu = preload("res://MM_Explosion.tscn")
	var p = piupiu.instantiate()
	get_parent().add_child(p)
	collision_layer = 0
	$Collision.disabled = 1
	$SlidingColl.disabled = 1
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://test_man_stage.tscn")
	Global.reset_vars()
	$State.change_state("Dead")
	
#Damage
func damage(damage):
	#$State.change_state("Hit")
	if is_invincible == false:
		Global.playerHP -= damage
		if Global.playerHP > 0:
			is_invincible = true
			#is_taking_damage = true
			$Invincibility.start()
			$Sprite/Flickering.play("flickering")
			Audio.playsfx2(damagesfx)
			#damage effect white sprite anim and stun
			$HitSprite/Anim.play("vis")
			await get_tree().create_timer(0.3).timeout
			$HitSprite/Anim.stop()
			is_taking_damage = false

func _on_invincibility_timeout():
	is_invincible = false
	$Sprite/Flickering.stop()

func _on_bubble_timeout():
	if under_water == true:
		Effect_manager.bubble()
		$Bubble.start()

func _on_sliding_timer_timeout():
	is_sliding = false
	WALK_SPEED = 82.5
	$Collision.disabled = false
	$SlidingColl.disabled = true

func change_anim(str):
	$Sprite/AnimationPlayer.play(str)

func shoot():
	var projectile_pos = $Shootpos.global_position
	$Shootpos.position.x = 13 * direction
	Global.player_dir = direction
	Effect_manager.shoot(projectile_pos)

