extends Node2D

var health := 2
var damage := 4
var left := true

@onready var BULLET = preload("res://EnemieBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D/AnimationPlayer.play("Shoot")
	#$Timer.start()
	if Global.playerxy.x > self.global_position.x:
		$Sprite2D.scale.x = -1
		left = false
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health == 0:
		destroyied()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func shoot():
	var a = BULLET.instantiate()
	get_parent().add_child(a)
	a.direction = (Global.playerxy - global_position).normalized()
	if left == false:
		a.position = Vector2(5,5)
	else:
		a.position = Vector2(-5,5)

func destroyied():
	var pos = self.global_position
	Effect_manager.explosion(pos)
	queue_free()





func _on_body_entered(player):
	player.damage(damage)


func _on_area_entered(area):
	health -= 1
	Audio.damagesfx()
	area.queue_free()
