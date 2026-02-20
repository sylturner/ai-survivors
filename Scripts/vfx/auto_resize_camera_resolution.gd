extends SubViewportContainer

@onready var viewport: SubViewport = $SubViewport

func _ready() -> void:
	# 1. Make the container fill the screen
	anchors_preset = Control.PRESET_FULL_RECT
	
	# 2. Connect to the window resize signal
	get_viewport().size_changed.connect(_on_window_resized)
	
	# 3. Initial size sync
	_on_window_resized()

func _on_window_resized() -> void:
	# Match the sub-viewport resolution to the main game resolution
	viewport.size = get_viewport().size
