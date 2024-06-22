extends Camera2D
var SPEEDinitial:float = 0.5
var SPEED=SPEEDinitial
var dir_in:Vector2 = Vector2.ZERO
var isDragged:int=0
var distance
var IsCameraLocked:int = 0
signal sizechanged
var camsize

func _ready():
	camsize = get_viewport().size

func _process(delta):
	if not GlobalScript.LockedOnObject or not IsCameraLocked:
		MoveifNotlocked(delta)
	else:
		MoveifLocked(delta)
	if camsize != get_viewport().size:
		camsize=get_viewport().size
		emit_signal("sizechanged")

func _input(event):
	handlezoom(event)
	detectdrag(event)
	HandleCamDrag(event)
	if event is InputEventKey and Input.is_action_just_pressed("ui_accept"	):
		IsCameraLocked = (IsCameraLocked + 1)%2

func HandleSpeedInput(boolvar):
		if(boolvar):
			if SPEED <= 20:
				SPEED=SPEED+SPEED/10
			else:
				SPEED=20
			return 1
		else:
			if SPEED>SPEEDinitial:
				SPEED=SPEED-0.25
			else:
				SPEED=SPEEDinitial

func handlezoom(event):
	if event.is_pressed() and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and zoom.x > 0.25:
			set_zoom(zoom/2)
			scale = Vector2(1 / zoom.x, 1 / zoom.y)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and zoom.x <= 10:
			set_zoom(zoom*2)
			scale = Vector2(1 / zoom.x, 1 / zoom.y)

func detectdrag(event):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				isDragged=(isDragged+1)%2
				
func HandleCamDrag(event):
		if event is InputEventMouseMotion and isDragged:
			move_local_x(-event.relative.x/zoom.x)
			move_local_y(-event.relative.y/zoom.x)

func MoveifNotlocked(delta):
	dir_in= Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	HandleSpeedInput(dir_in.x or dir_in.y)
	move_local_x(SPEED*dir_in.x*delta*60)
	move_local_y(SPEED*dir_in.y*delta*60)

func MoveifLocked(delta):
	distance=GlobalScript.LockedOnObject.position - position
	move_local_x(distance.x*delta*60)
	move_local_y(distance.y*delta*60)
