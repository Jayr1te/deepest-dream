@tool
extends Node

enum type { 
	NULL, 
	OXY, 
	MEM 
	}

var icons = [
	preload("res://icons/placeholder.png"),
	preload("res://icons/oxygen.png"),
	preload("res://icons/placeholder.png")
]

var colors = [
	Color(1.0, 1.0, 1.0, 1.0),
	Color(0.2, 0.561, 0.8),
	Color(0.451, 0.506, 1.0)
]
