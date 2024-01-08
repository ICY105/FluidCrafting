
#reroute to proper function
execute if entity @s[tag=fluid.tank] run function fluid:v1.4/pipe/break_machine
execute if entity @s[tag=fluid.pipe] run function fluid:v1.4/pipe/break_pipe
