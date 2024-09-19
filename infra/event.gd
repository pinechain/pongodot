class_name Event
extends Object


signal _event_param(param)


func trigger(param):
	_event_param.emit(param)


func sub(callable: Callable):
	_event_param.connect(callable)


func unsub(callable: Callable):
	_event_param.disconnect(callable)