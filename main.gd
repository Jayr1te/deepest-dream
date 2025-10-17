extends Node2D

var oxy : float = 5
var oxyMax : float = 5
var oxyBar : ProgressBar

var mem : float = 0
var memChange : float = 0
var memThres : float = 5
var memUnlocked : bool = false

var depth : float = 0
var swimSpeed : float = 1
var explore : float = 0

var diving : bool = false

func _ready() -> void:
	oxyBar = $CanvasLayer/OxyBar
	print(Math.fib(8))

func _physics_process(delta: float) -> void:
	
	oxyBar.offset_right = 100 * (log(oxyMax) / log(10))
	oxyBar.get_child(1).offset_left = 100 * (log(oxyMax) / log(10))
	oxyBar.get_child(1).offset_right = 100 * (log(oxyMax) / log(10))
	oxyBar.max_value = oxyMax
	oxyBar.value = oxy
	
	oxyBar.get_child(0).text = str(snapped(oxy,1))
	oxyBar.get_child(1).text = str(snapped(oxyMax,1))
	oxyBar.get_child(2).text = str(snapped(depth,1)) + "m"

	if mem > 0 and memUnlocked == false:
		memUnlocked = true
	
	$CanvasLayer/MemIcon.visible = memUnlocked
	
	$CanvasLayer/MemIcon/MemNumber.text = str(snapped(mem,1))
	$CanvasLayer/MemIcon/MemChange.offset_left = 45 + 4 + $CanvasLayer/MemIcon/MemNumber.size.x
	
	if snapped(depth,1) >= memThres:
		memThres += 5 + memChange
		memChange += 1
	
	if memChange > 0:
		$CanvasLayer/MemIcon/MemChange.text = "+ " + str(snapped(memChange,1))
	else:
		$CanvasLayer/MemIcon/MemChange.text = ""
	
	if diving:
		$CanvasLayer/Button.disabled = true
		$CanvasLayer/MemIcon/MemThres.text = "Next at " + str(snapped(memThres,1)) + "m"
		oxy -= 1 * delta
		
		if depth <= 100:
			depth += swimSpeed * delta
		else:
			#depth = 100
			depth += swimSpeed * delta
		
		if oxy <= 0:
			diving = false
			mem += memChange
			memChange = 0
	else:
		$CanvasLayer/Button.disabled = false
		$CanvasLayer/MemIcon/MemThres.text = ""
		if oxy < oxyMax:
			if oxy < 0:
				oxy = 0
			oxy += oxyMax * delta
			if oxy > oxyMax:
				oxy = oxyMax
		depth = 0
		explore = 0


func _on_button_pressed() -> void:
	diving = true
	memThres = 5


func _on_source_meta_clicked(meta: Variant) -> void:
	OS.shell_open("https://github.com/Jayr1te/deepest-dream")
