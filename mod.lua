-- example level following the 'bonus' style of level, with wall panel dialogue and doors
-- in Tiled we set the player's toolset to "none" so they don't spawn with any tools or books

local levelid = ''

return {

  --------------
  -- REQUIRED --
  --------------

  -- called once when the game loads (or when your mod is marked 'active')
  -- should return true unless there's an issue with loading any files you need
  load = function(mod_id)
    print('Hello world!', mod_id)


    -- register the level making it available to the player in the custom level world
    -- your level name in the game code will be referenced as mod_id + '_' + the name of the level file 
    -- in this case mod_id + '_' + custom1
    -- you could register more than one level here if you wanted, but should give them unique names to each other within your mod
    -- this function will return the level id for you to use later
    
    levelid = mod.register(mod_id, 'custom3', {
      -- level name for overworld
      name = 'Undefined Behaviour',

      -- the 3 beast slots shown in the overworld should match the beasts in your level
      -- in this case we have no beasts or stars
      beasts = {'', '', ''},
      stars = {'', '', ''},

      -- now we need some custom dialogue for the bot!
      dialogue = {
        -- to add wall panel dialogues, need to add 'xpanel' to the key
        modpanel_custom_ell1_a = {
          "Wotcha Chef! Got summink a bit different today, a weird little glitch I been noticin'",
          "You probably already know ya can place pipes with a preset direction by pressing <sp_key_r_item>, 'owever ya might not 'ave noticed that these pipes ignore normal checks.",
          "Combined with ya belts, this can lead to some intrestin' 'undefined behaviour'..."
        },
        -- reminder prompt before orders are taken
        -- the game looks for an 'x' to know it's done
        -- so only use the 'x' for the final npc that will trigger the level as done
        modpanel_custom_ell1_x = {
          "Nice work Chef! Is it a bug, or is it a feature I wonda?",
          "Best not tell Verr'dahn 'bout it, he might patch it out...",
        },
      },
        
      machines = {}
      
    })

    -- add level to bonusmap which marks the level as a 'bonus' leve
    -- this removes the top-right npc widget and makes sure the bot 
    -- cant be cliked on until all doors are opened
    -- you also won't have any books by default
    -- and as we set the player object's "toolset" to "none" you won't start with any either
    game.g.bonusmap[levelid] = {}

    return true
  end,

  -----------------
  -- CORE EVENTS --
  -----------------

  -- called twice every frame, once with type == 'obj' and once with type == 'ui'
  -- these are two seperate layers, the cam_x/cam_y for drawing relative to the camera
  draw = function(type, cam_x, cam_y)

  end,

  -- called every frame
  -- anything that should move smoothly should be updated every frame
  step = function(dt)

    -- make sure player can never get a blueprint or belt or salt as that defeats the purpose of the level
    if game.g.player and game.g.level == levelid then
      for s=1,#game.g.player.menu.slots do
        local slot = game.g.player.menu.slots[s]
        if slot.item == 'blueprint' or slot.item == 'belt' or slot.item == 'salt' then
          slot:clear()
        end
      end
    end

  end,

  -- called every 0.1s
  tick = function()

  end,

  -- called every 1s
  tock = function()

  end,

  ---------------
  -- GAMESTATE --
  ---------------

  -- called any time a player starts a level
  start = function()

    if game.g.level == levelid then
      -- do something when starting your level!
    end

  end,

  -- called whenever the game is saved
  -- you can check the current 'slot' with game.g.file_slot
  save = function()

  end,

  -- called when the game is closed, chance to save any mod data you want to
  quit = function()

  end,

  -----------
  -- INPUT --
  -----------

  -- called from mouse clicking, type is either 'pressed' or 'released'
  -- 'button' is either 1 (left) 2 (right) or 3 (middle)
  -- hook is either 'before' or 'after' the game's own mouse click code
  mouse = function(type, button, hook)

  end,

  -- called from pressing a key, 'key' is the actual value of the key
  -- 'scancode' is the key value relative to the standard US qwerty keyboard layout
  -- 'is_repeat' is true if double-tapped
  key = function(key, scancode, is_repeat)

  end,

  -- called from a gamepad input press
  -- gtype is 'pressed' or 'released'
  -- button is all the standard love gamepad buttons: https://love2d.org/wiki/GamepadButton
  -- as well as a few custom ones for big triggers: 'triggerleft', 'triggerright'
  -- plus custom ones for analog stick flicks: 'dpup2', 'dpdown2', 'dpleft2', 'dpright2'
  gamepad = function(gtype, button)

  end,

  -- called on mousewheel scroll, px and py are scroll amount
  -- inv is true on platforms that flip the scroll direction, i.e. MacOS
  scroll = function(px, py, inv)

  end,

  -- called as the player types on their keyboard
  textinput = function(text)

  end,


}
