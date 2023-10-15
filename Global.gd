extends Node2D

@export var MM_max_shoot_num := 3
var player_dir = 1
var playerxy = Vector2()
var playerHP := 28
var current_respawnxy = Vector2i.ZERO
var underwater := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_vars():
	playerHP = 28
