extends "res://Scripts/Stickman.gd"

var inventory = {}
#3   inventory['Apple'] = [15, 8]

signal on_death

func _ready():
	self.hp = 90
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.entity_group)

func pick(item):
	var it = item.get_item()
	if it in inventory.keys():
		inventory[it][0] += item.get_amount()
	else:
		inventory[it] = [item.get_amount(), item.get_item_stack()]
	ui.update_inventory(inventory)

func _process(delta):
	
	var velocity = Vector2()
	if Input.is_action_pressed("up"):
		velocity.y -= speed
	if Input.is_action_pressed("down"):
		velocity.y += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		velocity.x += speed
	move_and_slide(velocity)
	
	position.x = clamp(position.x, 0, 10000)
	position.y = clamp(position.y, 0, 10000)
	
	$DamagePos.position = get_global_mouse_position() - position
	$DamagePos.position.x = clamp($DamagePos.position.x, -24, 40)
	$DamagePos.position.y = clamp($DamagePos.position.y, -24, 40)

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		ui.toggle_inventory(inventory)
	if event.is_action_pressed("left_click"):
		var a = load("res://Scenes/DamageArea.tscn").instance()
		a.set_damage(10)
		get_parent().add_child(a)
		a.position = position + $DamagePos.position

func die():
	emit_signal("on_death")
	.die()


func save():
	var data = .save()
	data["inventory"] = inventory
	return data


func load_from_data(data):
	.load_from_data(data)
	inventory = data["inventory"].duplicate(true)
	
	
	
