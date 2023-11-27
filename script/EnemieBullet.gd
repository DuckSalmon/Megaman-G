extends Area2D

#@onready var gfx = preload("res://assets/GFX/Enemies/bullet1.png")
var damage := 2
var speed = 240
var direction := Vector2(1, 0)
var mirrored := false

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Sprite2D.texture = gfx
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(speed*delta*direction)
	if mirrored == true:
		$sprite.flip_h = true
		$CollisionShape2D.position.x = 5


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(player):
	player.damage(damage)
