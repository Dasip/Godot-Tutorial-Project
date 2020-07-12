extends Node2D

var item = ""
var amount = 1
var stack_limit = 8

func set_item(properties):
	$Sprite.texture = load("res://Sprites/Items/%s.png" % properties[0])
	item = properties[0]
	stack_limit = properties[1]

func _ready():
	pass

func get_item():
	return item

func get_amount():
	return amount

func get_item_stack():
	return stack_limit

func _input(event):
	if event.is_action_pressed("e_click"):
		var pl = get_parent().get_parent().get_player()
		if abs(pl.position.x - position.x) < 64 and abs(pl.position.y - position.y) < 64:
			get_parent().remove_child(self)
			pl.pick(self)


func save():
	var data = {
		"filename": get_filename(),
		"position": position,
		"item": item,
		"amount": amount,
		"stack_limit": stack_limit
	}
	
	return data


func load_from_data(data):
	position = data["position"]
	set_item([data["item"], data["stack_limit"]])
	amount = data["amount"]



