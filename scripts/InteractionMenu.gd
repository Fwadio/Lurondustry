extends Panel
const  InteractionButton = preload("res://scenes/interactionButton.tscn")
var children:Array
signal Build(ID)
var x0:float=10
var y0:float=5
var StartMenu: Dictionary ={
	0:{"Name":"Attack*" , "function":"LoadAttackMenu"},
	1:{"Name":"Build" , "function":"LoadBuildMenu"},
	2:{"Name":"More*" , "function":"LoadMoreMenu"},
}
var BuildMenu: Dictionary ={
	0:{"Name":"<-","function":"LoadPreviousMenu"},
	1:{"Name":"Wall","function":"Build","ID":"Basic wall"}
}
var MenuBuffer: Dictionary = StartMenu
var PreviousMenu: Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	loadMenu(StartMenu)
	pass # Replace with function body.

func Interactions(funcName ,emitter):
	match funcName:
		"LoadBuildMenu":
			clear()
			loadMenu(BuildMenu)
		"Build":
			emit_signal("Build",emitter.ID)
		"LoadPreviousMenu":
			clear()
			loadMenu(PreviousMenu)
		_:
			print("Not Recognized")
	pass

func loadMenu(Dict:Dictionary):
	PreviousMenu = MenuBuffer
	MenuBuffer = Dict
	var maxOptionsPerLine: int = 5
	for i in Dict:
		add_child(InteractionButton.instantiate())
	children=get_children()
	for i in range(get_child_count()):
		children[i].position=Vector2(x0+90*(i%maxOptionsPerLine),5 + 90*(int(i/maxOptionsPerLine)))
		children[i].connect("InteractionClicked",Interactions)
		children[i].Name.text=Dict[i]["Name"]
		children[i].function=Dict[i]["function"]
		if "ID" in Dict[i]:
			children[i].ID=Dict[i]["ID"]
	
	
func clear():
	for n in get_children():
		n.disconnect("InteractionClicked",Interactions)
		remove_child(n)
		n.queue_free()
