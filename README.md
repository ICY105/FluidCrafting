# FluidCrafting
Custom fluid mechanics library for Minecraft Datapacks. This does not add in-world fluids, but does add systems for storing, transporting, and using custom fluids in blocks and items. See [Mechanization](https://github.com/ICY105/Mechanization) for examples of how this is used in practice. This is a very advanced library. Don't attempt using this unless you know what you're doing. If you need practice, try using the [DatapackEnergy](https://github.com/ICY105/DatapackEnergy) library. It's very similiar, but less complicated as it doesn't involve NBT definitions.

This library manages:
* NBT definitions for fluids
* Designating block marking entities as entities that can store fluids
  - Scoreboard and NBT definitions for storing fluid
  - Up to 4 different fluid types can be stores per block
  - Supporting functions for managing fluids, such as Inputing/Outputting fluids with items (ie bucket)
* Designating block marking entities as pipes that can transfer fluids
  - Automaticly link to tanks
  - Automatic fluid transfering between enabled blocks
  - Model Data for easily displaying connections
* Designating items as holding a fluid

This is an embedded library, so you package it inside your datapack as opposed to having a separate download. Requires [LanternLoad](https://github.com/LanternMC/load) to operate.

Depending on your use case, you may be able to use FluidCrafting's data format without using the library itself, with compatibility being enabled if another datapack is using Fluid Crafting. For example, if you have a Tinker's Construct datpack, you can store the smeltery's fluid in FluidCrafting's format, then if Mechanization is installed it can pump fluid in/out of the smeltary.

# NBT Format
This specifies how FluidCrafting intereprets NBT data, specifically for fluid-containing items.
```
Arbitarty Fluid:
    fluid:{id:"fluid_id", temperature: 0, color: 0, gas: 0b, name:'{"text":"name"}'}
        id: id of fluid, used to check if fluids are equal. If you want a pack-exclusive fluid (no one else will use it), set the id to <pack:fluid>. If you want a cross-datapack fluid (like water), set to just <fluid>.
        temperature: temp of fluid, in degrees C. Not used internally, but can be used by your datapack to gain information abount what the fluid is. For example, you can prevent a tank from storing hot fluids like lava.
        color: Color of the liquid, in decimial format (same format as leather armor). Not used internally. Intended to be used for color shading UI elements.
        gas: if this fluid is a gas, ie. Steam. Not used interanlly.
        name: JSON name of fluid. Not used internally. Intended for any time your datapack needs to reference a fluid by name. Note: default vanilla fluids have missing translation strings using fallback.
```

```
Item:
    Item.tag.fluid{<fluid data>, storage: 1000, max_storage: 1000, fixed_storage: 0b}
       <fluid data>: the NBT definition of a fluid, in the same level. ie. Item.tag.fluid{id:"fluid_id", ..., storage: 1000}. Don't include for empty fluid storage items.
       storage: how much fluid is currently stored
       max_storage: how much fluid can be stored
       fixed_storage: if the item can only hold a specific amount of fluid (ie. exactly 1000/1000), or an arbitrary amount (ie. 420/1000)

Armor Stand (tank):
    ArmorItems[3].fluids:[{<data>}, ...]

[Glowing] Item Frame (tank):
    Item.tag.fluids:[{<data>}, ...]

Item Display (tank):
    item.tag.fluids:[{<data>}, ...]

Marker (tank):
    data.fluids:[{<data>}, ...]
    ...
```

# Scoreboard Data
```
fluid.data
    Used to pass data between functions and for storing arbitrary data on an entity.

    On a pipe, this is a binary encoded number of which sides are connected, ie:
          up down north south east west
    63 -> 1  1    1     1     1    1    -> all sides are active
	      1  2    4     8     16   32
    This can be used to update the model to display connections when 
    function #fluid:v1/pipe_update is triggered.
```

```
fluid.transfer_rate
    Caps how much fluid can be pump in/out of a tank, and how much fluid a pipe network can handle.
    The rate is limited by the lowest rate in the entire network.

    Make sure this score is 1+ on all pipes and tanks.
```

```
fluid.storage.0
fluid.storage.1
fluid.storage.2
fluid.storage.3
    Indicates how much fluid is stored in each of the 4 fluid slots.
```

```
fluid.max_storage.0
fluid.max_storage.1
fluid.max_storage.2
fluid.max_storage.3
    Indicates how much fluid can be stored in each of the 4 fluid slots. Set to 0 to disable that slot.
```

```
fluid.io.up
fluid.io.down
fluid.io.north
fluid.io.south
fluid.io.east
fluid.io.west
    Sets which tank slots interface with which sides, and whether they input or output. Postive numbers accept fluids, negative numbers expell fluid.
    Set the value to a binary encoded number representing which tank slots are enabled, ie:
    15 -> 1  1  1  1 -> all tanks are active
	      1  2  4  8
    For example, if you only want tank slot 1 to input, set to 1. If you want slot 2 and 3 to output, set to -6.
```

# Selector Tags
Selector tags indicate FluidCrafting should do something with the tagged entity.
```
fluid.tank
    Indicates entity should store fluids. Must be one of the supported entities: Armor Stand, [Glowing] Item Frame, Marker, Item Display. If you need a different entity, let me know. It must support arbitrary NBT data. Note that for most entities the NBT data is stored on the item, so replacing the item will clear the tank.

fluid.pipe
    Indicates entity is a pipe that should connect tanks.
```

# Function Calls
You make function calls from your datapack whenever you want FluidCrafting to execute a specific task.
```
function fluid:v1/api/init_pipe
  Call on a new pipe to initialize its connections

function fluid:v1/api/init_tank
  Call on a new tank to initialize its connections
```

```
function fluid:v1/api/break_pipe
  Call on a pipe when broken to remove its connections

function fluid:v1/api/break_tank
  Call on a tank when broken to remove its connections
  
Failure to call these breaking functions has negative side-effects
like tanks remaining in the same network without being connected.
Make sure to call these when needed!
```

```
function fluid:v1/api/slot_io
    Manages fluid IO via items. For example, providing a bucket of water will attempt to put 1000 units of water in a tank. Supports custom fluid container items (see NBT reference). This items can be visually updated via function tag.
    > score #score #slot_io.in fluid.data: which tank slot to interact with
    > storage fluid:io input:{input_slot:{<item>}, output_slot:{<item>}}: A copy of the slot used for the input item, and the slot used for the output item.
    < storage fluid:io output:{input_slot:{<item>}, output_slot:{<item>}}: Returns modified copies of the provided items. Set the items slots to these values.
```

# Function Tags
Function tags are called by FluidCrafting when it needs your datapack to do something. You need to add a function to FluidCrafting's function tag list for each function.
```
#fluid:v1/pipe_update
    Runs when a pipe has been updated. You can use this to change its model to display new connections.
```

```
#fluid:v1/pipe_can_connect
  Executed as and at a tank.
  Used to disable pipes connecting to a tank from certain sides.
  #pipe.in fluid.data -> 0-5 indicating direction (up, down, north, south, east, west)
  #pipe.out fluid.data -> 1 for can connect, 0 for cannot connect (defaults to can connect)
```

```
#fluid:v1/tank_fluid_update
    Runs when a the fluid level of a tank has changed. You can use this to update display information.
```

```
#fluid:v1/tank_fluid_accept
    Runs as a tank when a fluid is requesting to be pumped in. Use this to filter what fluids are accepted
    > storage fluid:io fluid: the fluid being pumped in
    > score #network.tank fluid.data: the slot the tank is in
    < score #out fluid.data: set to 0 deny fluid, defaults to 1
```

```
#fluid:v1/modify_fluid_item
    Runs when a fluid containing item is modified: either adding fluid or removing it.
    Use this to update the item's model, name, lore, etc.
    <> storage fluid:io output.output_slot: the item. The fluid is contained in output.output_slot.tag.fluid
```

# How to use
1. Install [LanternLoad](https://github.com/LanternMC/load) in your datapack
2. Copy the `data/fluid` folder into your data pack
3. Merge the contents of `/data/load/tags/functions/load.json` and your own `data/load/tags/functions/load.json`
4. Implement the API as described above.
5. [Optional] Add the contents of `assets/` to your resourcepack.

For easier mangament of dependencies, check out my project [Datapack Build Manager](https://github.com/ICY105/DatapackBuildManager).
