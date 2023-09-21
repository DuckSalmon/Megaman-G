extends Node2D

@onready var particle = preload("res://ExplParticle.tscn")

func _ready():
	var a = particle.instantiate()
	get_parent().add_child(a)
	a.speed *= 1.41
	var b = particle.instantiate()
	get_parent().add_child(b)
	b.direction = Vector2i(-1,0)
	b.speed *= 1.41
	var c = particle.instantiate()
	get_parent().add_child(c)
	c.direction = Vector2i(0,-1)
	c.speed *= 1.41
	var d = particle.instantiate()
	get_parent().add_child(d)
	d.direction = Vector2i(0, 1)
	d.speed *= 1.41
	#diagonal particles
	var e = particle.instantiate()
	get_parent().add_child(e)
	e.direction = Vector2i(1, -1)
	var f = particle.instantiate()
	get_parent().add_child(f)
	f.direction = Vector2i(-1, -1)
	var g = particle.instantiate()
	get_parent().add_child(g)
	g.direction = Vector2i(1, 1)
	var h = particle.instantiate()
	get_parent().add_child(h)
	h.direction = Vector2i(-1, 1)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func bum():
	var b = particle.instantiate()
	get_parent().add_child(b)
	b.position = Global.playerxy
