extends Panel
const  InteractionButtonScene = preload("res://scenes/interactionButton.tscn")
signal ButtonPressed(ID, params)

const Menus :Dictionary= {
	"StartMenu":[
		{"Name":"Attack*" , "function":"LoadSubMenu", "ID": "AttackMenu"},
		{"Name":"Build" , "function":"LoadSubMenu", "ID":"BuildMenu"},
		{"Name":"More*" , "function":"LoadSubMenu", "ID":"More"},
	],

	"BuildMenu":[
		{"Name":"<-","function":"LoadSubMenu", "ID": "StartMenu"},
		{"Name":"Wall","function":"Build","ID":"Basic wall"}
	]
}

var MenuBuffer: String = "StartMenu"
var PreviousMenu: String

func _ready():
	loadMenu("StartMenu")

func interactions(funcName ,emitter):
	if(funcName == "LoadSubMenu"):
		loadMenu(emitter.ID)
	else:
		emit_signal("ButtonPressed", emitter.function, emitter.ID)

func loadMenu(Menu:String):
	const x0:float=10
	const y0:float=5
	var children:Array
	PreviousMenu = MenuBuffer
	MenuBuffer = Menu
	var maxOptionsPerLine: int = 5
	var MenuBtns = Menus[Menu]
	
	clear()
	for i in MenuBtns:
		add_child(InteractionButtonScene.instantiate())
	children=get_children()
	for i in range(get_child_count()):
		children[i].position=Vector2(x0+90*(i%maxOptionsPerLine),5 + 90*(int(i/maxOptionsPerLine)))
		children[i].connect("InteractionClicked",interactions)
		children[i].Name.text= MenuBtns[i]["Name"]
		children[i].function=MenuBtns[i]["function"]
		if "ID" in MenuBtns[i]:
			children[i].ID= MenuBtns[i]["ID"]
	
	
func clear():
	for n in get_children():
		n.disconnect("InteractionClicked",interactions)
		remove_child(n)
		n.queue_free()
