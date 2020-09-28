extends AudioStreamPlayer

func _ready():
	connect("finished", self, "queue_free")
