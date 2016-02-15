# Fun with Lua

This code documents common data mining processing patterns
(see elsewhere for the excellent 
[functional programming in Lua library](http://rtsisyk.github.io/luafun/)).

## Why Fun? 

This code is an experiment in a combined data mining/multi-objective
optimization toolkit. Given 
[recent success with adding data mining inside an optimizer](http://goo.gl/nOAc7w), it might be possible to simplify and unify
data mining and optimization with a single simple set of data structures.

Or not. This is work in progress. Watch this space.

## Installation

To use:

1. Install Lua. Install LuaJit (if you want faster code). 
2. In  a fresh directory, download [fun.zip](fun.zip).

To contribute:

1. Check out this repo in Github. Do the usual things. Code contribs gladly accepted!

## Testing

All my `x.lua` files have an associated `xok.lua` file which contains
tests for `x.lua`. To run thise tests, after unzipping or checking out, run:

    bash oks
    
which loads all the `*ok.lua` files in the current directory. That code should
**NOT** output the word _Failure_, except for the   tests  that
test if the test system is working. So please ignore the following lines:

```
Failure: aaaok.lua:5: oh dear 
Failure: aaaok.lua:10: oh dear,again 
```
      
      
## Documentation
  
  
### Conventions

Lua is a "batteries not included" language. To see the "batteries"
I added, which includes a small OO extension to Lua, read [aaa.lua](aaa.lua).


In the following description anything starting with `U`pper case is
a class and anyting starting with `l`ower case is a slot. 
Lua data objects are defined in `code` font while anything about
files or particular data items are shown in _italic_ font.


### Goal 

The goal of `Fun` is to generate a non-parametric version of

    y = Fun(x)
    
where `x,y` can be multiple `Col`umns (so these functions input mulitiple inputs
and generate mulitple outputs.

All columns are either:

+ `Num`bers: things that can be added, multiplied, etc
+ `Sym`bols: things that can only be counted and comparied with `==`.

The central object here is `Fun`; i.e. a `Fun`ction object
that stores examples of how outputs `y` are conneceted to inputs `x`. 

```lua
Fun=Object:new{
  name="",     rows   = {},
  x      = {}, y      = {}, headers= {},
  spec   = {}, more   = {}, less   = {},
  klass  = {}, nums   = {}, syms   = {}
}
```

As shown above, `Fun` objects store its examples as `rows`, plus some
`headers` informatiion about each column. Each header has a `name` and
knows
its `pos`ition within each row.  These `headers` are generated from
a `spec` that is a list of column names with some magic prefix character.
For example, if the `spec` is

    outlook, $temperature, windy,=play

then _outlook,windy_ are `Sym`bols while _temperature_ is `Num`ber.
Also, _play_ is a `klass` (which is also a `Sym`bol).  Other magic
characters are defined in the top of the _nsv.lua_ file.

    klass      = "=",
    less       = "<",
    more       = ">",
    floatp     = "[\\$]",
    intp       = ":",
    goalp      = "[><=]",
    nump       = "[:\\$><]",
    dep        = "[=<>]"
