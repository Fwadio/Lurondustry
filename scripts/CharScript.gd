extends CharacterBody2D

const SPEED = 300.0
var dir_in:Vector2
var unitName="John Godot"
var moving = false
var clickPosition
var targ_pos

signal selected(selected:bool, unitSelected)

#UNIT MOVEMENT
func _physics_process(delta):
	if GlobalScript.LockedOnObject:		
		dir_in= Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		velocity=dir_in*SPEED*delta*60
		
		if Input.is_action_just_pressed("left click") and !Input.is_action_pressed("ui_crtl"):
			clickPosition= get_global_mouse_position()
			look_at(clickPosition)
			targ_pos=(clickPosition-position).normalized()
			moving = true

		if clickPosition and abs(position.distance_to(clickPosition))>10 and moving :
			velocity=lerp(position,clickPosition,SPEED).normalized()*SPEED
		
		move_and_slide()
		
		if velocity == Vector2(0,0):
			moving = false 
			
#UNIT SELECTION
		
func _on_world_cancel_key_pressed():
	select_unit(false)
	
func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		select_unit(true)

func select_unit(isSelected:bool):
	emit_signal("selected", isSelected, self)
