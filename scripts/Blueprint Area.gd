extends Area2D
@onready var Parent = $".."
var CanPlace:bool = true
var FinishedBuilding: bool = false

func _ready():
	Parent.set_collision_layer_value(1,0)
	Parent.set_collision_layer_value(2,1)
	Parent.set_collision_mask_value(2,1)

func _input(event):
	if Parent.followCursor:
		if Input.is_action_just_pressed("left click") and CanPlace:
			Parent.followCursor = false
		if Input.is_action_just_pressed("right click"):
			Parent.rotate(deg_to_rad(18))

func _process(delta):
	build_self(not FinishedBuilding and not Parent.followCursor , delta)
	print(not FinishedBuilding and not Parent.followCursor)
	kill_self(FinishedBuilding)
	if(Parent.followCursor):
		Parent.position=get_global_mouse_position()
	pass
	
func _on_body_entered(body):
	Parent.sprite_2d.modulate=Color(Parent.CantPlaceColor)
	if body != Parent and Parent.followCursor:
		CanPlace=false



func _on_body_exited(body):
	if Parent.followCursor and not has_overlapping_bodies():
		Parent.sprite_2d.modulate=Color(Parent.CanPlaceColor)
		CanPlace=true
	pass # Replace with function body.
	
func kill_self(isVrai: bool):
	if(isVrai):
		Parent.followCursor=false
		Parent.sprite_2d.modulate=Color(1, 1, 1, 1)
		Parent.set_collision_layer_value(1,1)
		Parent.set_collision_layer_value(2,0)
		Parent.set_collision_mask_value(2,0)
		Parent.remove_child(self)
		queue_free()

func build_self(isVrai,delta):
	if (isVrai):
		Parent.sprite_2d.modulate.r=1
		Parent.sprite_2d.modulate.g=1
		Parent.sprite_2d.modulate.b=1
		if(Parent.sprite_2d.modulate.a <= 2.0):
			Parent.followCursor=false
			Parent.sprite_2d.modulate.a=Parent.sprite_2d.modulate.a+Parent.BuildTime/2*delta
		else:
			FinishedBuilding=true
