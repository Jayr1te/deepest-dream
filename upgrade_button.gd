@tool
extends Button



signal values_changed

@export var cost : Array = [] :
	set(value): 
		cost = value
		values_changed.emit() 
@export var costType : Array = [] :
	set(value): 
		costType = value
		values_changed.emit()
@export var name_ : String :
	set(value): 
		name_ = value
		values_changed.emit()
@export var desc : String :
	set(value): 
		desc = value
		values_changed.emit()
@export var eff : String :
	set(value): 
		eff = value
		values_changed.emit()
@export var effType : Array = [] :
	set(value): 
		effType = value
		values_changed.emit()
@export var effAmount : Array = [] :
	set(value): 
		effAmount = value
		values_changed.emit()

var eIcon

func _ready() -> void:
	
	if Engine.is_editor_hint():
		eIcon = Node.new()
		eIcon.set_script(load("res://icon_manager.gd"))
		add_child(eIcon)
		editor_update()
		return
	
	$Name.text = name_
	$Description.text = desc
	$Effect.text = eff
	
	iconify($Name)
	iconify($Description)
	iconify($Effect)
	
	$Cost.clear()
	for i in cost.size():
		$Cost.append_text(str(cost[i]))
		var type = costType[i]
		$Cost.add_image(Icon.icons[type],25,25,Icon.colors[type],5,Rect2(),null)

func iconify(label : RichTextLabel):
	var textArray = label.text.split(" ")
	
	label.clear()
	var iconSize = label.get_theme_font_size("normal_font_size") / 16.0
	for s in textArray:
		if s.begins_with("[") && s.ends_with("]") && Icon.type.get(s.substr(1,s.length() - 2)):
			@warning_ignore("shadowed_variable_base_class")
			var icon = Icon.type.get(s.substr(1,s.length() - 2))
			@warning_ignore("int_as_enum_without_cast")
			label.add_image(Icon.icons[icon],25 * iconSize,25 * iconSize,Icon.colors[icon],5,Rect2(),null)
		else:
			label.append_text(s + " ")

func editor_update():
	$Name.text = name_
	$Description.text = desc
	$Effect.text = eff
	
	eIconify($Name)
	eIconify($Description)
	eIconify($Effect)
	
	$Cost.clear()
	for i in cost.size():
		$Cost.append_text(str(cost[i]))
		$Cost.add_image(get_child(4).icons[costType[i]],25,25,get_child(4).colors[costType[i]],5,Rect2(),null)

func eIconify(label : RichTextLabel):
	var textArray = label.text.split(" ")
	
	label.clear()
	var iconSize = label.get_theme_font_size("normal_font_size") / 16.0
	for s in textArray:
		if s.begins_with("[") && s.ends_with("]") && get_child(4).type.get(s.substr(1,s.length() - 2)):
			@warning_ignore("shadowed_variable_base_class")
			var icon = get_child(4).type.get(s.substr(1,s.length() - 2))
			@warning_ignore("int_as_enum_without_cast")
			label.add_image(get_child(4).icons[icon],25 * iconSize,25 * iconSize,get_child(4).colors[icon],5,Rect2(),null)
		else:
			label.append_text(s + " ")

func _on_values_changed() -> void:
	editor_update()
