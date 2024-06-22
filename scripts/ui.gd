extends CanvasLayer

@onready var textSelection = $UIhandler/BoxContainer/TextSelection

func changeTxt(textID:String, textValue:String):
	if(textID == "Selection"):
		textSelection.text = textValue
