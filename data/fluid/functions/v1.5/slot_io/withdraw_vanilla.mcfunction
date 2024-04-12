
scoreboard players set #success fluid.data 0

# bucket
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -2 if data storage fluid:io fluid{id:"water"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:water_bucket",count:1b}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -2 if data storage fluid:io fluid{id:"lava"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:lava_bucket",count:1b}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -2 if data storage fluid:io fluid{id:"milk"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:milk",count:1b}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -2 if data storage fluid:io fluid{id:"powder_snow"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:powder_snow_bucket",count:1b}

# glass bottle
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 if data storage fluid:io fluid{id:"water"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:potion",count:1b,components:{"minecraft:potion_contents":{potion:"minecraft:water"}}}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 if data storage fluid:io fluid{id:"honey"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:honey_bottle",count:1b}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run data modify storage fluid:io output.output_slot set value \
    {id:"minecraft:potion", count:1b, components:{"minecraft:potion_contents":{custom_color: 0}, "minecraft:hide_additional_tooltip":{}, "minecraft:item_name":'{"text":""}', "minecraft:custom_data":{custom_fluid_storage:1b, fluid:{}} }}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run data modify storage fluid:io output.output_slot.components."minecraft:custom_data".fluid set from storage fluid:io fluid
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run data modify storage fluid:io output.output_slot.components."minecraft:custom_data".fluid merge value {storage:333, max_storage:333}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run data modify storage fluid:io output.output_slot.components."minecraft:potion_contents".custom_color set from storage fluid:io fluid.color
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run data modify block -30000000 0 3202 front_text.messages[0] set value '{"translate":"item.fluidcrafting.generic_bottle","fallback":"Bottle of %s","with":[{"nbt":"fluid.name","storage":"fluid:io","interpret":true}],"italic":false}'
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run data modify storage fluid:io output.output_slot.components."item_name" set from block -30000000 0 3202 front_text.messages[0]
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -3 run scoreboard players set #success fluid.data 1

# bowl
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -4 if data storage fluid:io fluid{id:"mushroom_stew"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:mushroom_stew",count:1b}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -4 if data storage fluid:io fluid{id:"rabbit_stew"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:rabbit_stew",count:1b}
execute if score #success fluid.data matches 0 if score #slot_io.input_item fluid.data matches -4 if data storage fluid:io fluid{id:"beetroot_soup"} store success score #success fluid.data run data modify storage fluid:io output.output_slot set value {id:"minecraft:beetroot_soup",count:1b}

# modify data
execute if score #success fluid.data matches 1 run scoreboard players remove #slot_io.input_count fluid.data 1
execute if score #success fluid.data matches 1 run scoreboard players add #slot_io.output_count fluid.data 1
execute if score #success fluid.data matches 1 run scoreboard players operation #slot_io.storage fluid.data -= #slot_io.output_amount fluid.data

# correct for 1/3 items
execute if score #success fluid.data matches 1 run scoreboard players operation #temp fluid.data = #slot_io.storage fluid.data
execute if score #success fluid.data matches 1 run scoreboard players operation #temp fluid.data %= #cons.1000 fluid.data
execute if score #success fluid.data matches 1 if score #slot_io.output_amount fluid.data matches 333 if score #temp fluid.data matches 667 run scoreboard players remove #slot_io.storage fluid.data 1
