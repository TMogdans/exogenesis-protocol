class_name Modification
extends Resource

var stack_count := 0
var max_stacks := 10

## Applies the modification to the given projectile  
## Returns: void
func apply(projectile: Projectile) -> void:
    push_error("Method apply() must be overridden")

func can_stack() -> bool:
    return stack_count < max_stacks