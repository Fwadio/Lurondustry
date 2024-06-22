extends Button
@onready var Name:Label = $Name
@onready var Icon = $Sprite/Icon
var ID:String
signal  InteractionClicked(function,_emitter)
@export var function:String

func _on_button_down():
	emit_signal("InteractionClicked",function,self)

