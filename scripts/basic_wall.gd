extends StaticBody2D

var followCursor:bool=true
var CanPlaceColor:Color = Color(0, 1, 0, 0.5)
var CantPlaceColor:Color = Color(1, 0, 0, 0.5)

@onready var blueprint_area = $"Blueprint Area"
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D
var BuildTime: float = 2.0  # time to build in secs
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.modulate=Color(1, 1, 1, 0.5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
