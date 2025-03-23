NrioStuff = {
  mod = SMODS.current_mod,
  path = SMODS.current_mod.path:gsub("/$", ""),
  load_chace = {},
  G = {},
  round_vars = {},
  game_objects = {},
  config = SMODS.current_mod.config,
  config_ui = {},
}

SMODS.Atlas {
  key = "modicon",
  path = "modicon.png",
  px = 100,
  py = 100,
}


function NrioStuff.load(path)
  local module = NrioStuff.load_chace[path]
  if not module then
    module = assert(SMODS.load_file("src/" .. path .. ".lua"))()
    NrioStuff.load_chace[path] = module
  end
  return module
end

function NrioStuff.loads(...)
  for _, path in ipairs { ... } do
    NrioStuff.load(path)
  end
end


local usingVirtualizedMultiplayer=SMODS.Mods and SMODS.Mods["VirtualizedMultiplayer"] and SMODS.Mods["VirtualizedMultiplayer"].can_load or false

NrioStuff.load("edition")("editions", {
	"positive",
	"divinatory",
	"galactic",
	"prismatic"
})

function SMODS.current_mod.reset_game_globals() 
  for key, value in pairs(NrioStuff.round_vars) do
    G.GAME.current_round["nrios_" .. key] = value(G.GAME.current_round["nrios_" .. key])
  end
end
