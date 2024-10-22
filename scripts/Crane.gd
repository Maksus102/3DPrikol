extends Node3D
class_name Crane
static var num = 0
@export var max_h = 150.0
var cur_h = 5.0
@export var max_speed = 10.0
var cur_speed = 0.0
@export  var max_carry = 250.0
var item_w = 0.0
var c_x = 0
var c_y = 0
var has_item = false
var is_active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	transform.origin.y = 0
	pass # Replace with function body.
	
func Move(xval,yval,hval):
	transform.origin.x = xval
	transform.origin.z = yval
	if (cur_h > max_h):
		transform.origin.y = max_h
	elif (cur_h < max_h):
		transform.origin.y = cur_h
	
	
static func CurPos(c_x, c_y, cur_h):
	return "X:{0}, Y:{1}, H:{2}".format({"0":c_x, "1":c_y, "2":cur_h})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
