ns_config = SMODS.current_mod.config

if ns_config["Editions"] == nil then
  ns_config["Editions"] = true
end
if ns_config["Blind Editions"] == nil then
  ns_config["Blind Editions"] = true
end
if ns_config["Collabs Editions"] == nil then
  ns_config["Collabs Editions"] = true
end
if ns_config["Decks and Sleeves"] == nil then
  ns_config["Decks and Sleeves"] = true
end
if ns_config["Jokers :D"] == nil then
  ns_config["Jokers :D"] = true
end
if ns_config["Consumable!!!!"] == nil then
  ns_config["Consumable!!!!"] = true
end

NrioStuff = {
  mod = SMODS.current_mod,
  path = SMODS.current_mod.path:gsub("/$", ""),
  load_chace = {},
  G = {},
  round_vars = {},
  game_objects = {},
  config = ns_config,
  config_ui = {},
}

SMODS.Atlas {
  key = "modicon",
  path = "modicon.png",
  px = 100,
  py = 100,
}

local nriostuffTabs = function() return {
	{
		label = localize("ns_config_features"),
		chosen = true,
		tab_definition_function = function()
			ns_nodes = {}
			settings = { n = G.UIT.C, config = { align = "tm", padding = 0.05 }, nodes = {} }
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("ns_config_editions"), ref_table = ns_config, ref_value = "Editions" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("ns_config_bb_editions"), ref_table = ns_config, ref_value = "Blind Editions" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("ns_config_c_editions"), ref_table = ns_config, ref_value = "Collabs Editions" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("ns_config_decksluwu"), ref_table = ns_config, ref_value = "Decks and Sleeves" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("ns_config_jokers"), ref_table = ns_config, ref_value = "Jokers :D" })
      settings.nodes[#settings.nodes + 1] =
        create_toggle({ label = localize("ns_config_con_sum_able"), ref_table = ns_config, ref_value = "Consumable!!!!" })
			config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
			ns_nodes[#ns_nodes + 1] = config
			return {
				n = G.UIT.ROOT,
				config = {
					emboss = 0.05,
					minh = 6,
					r = 0.1,
					minw = 10,
					align = "cm",
					padding = 0.2,
					colour = G.C.BLACK,
				},
				nodes = ns_nodes,
			}
		end,
	},
} end
SMODS.current_mod.extra_tabs = nriostuffTabs

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

if ns_config["Editions"] then
	NrioStuff.load("edition")("editions", {
		"positive",
		"divinatory",
		"galactic",
		"prismatic"
	})
end

if ns_config["Blind Editions"] and G.P_BLIND_EDITIONS then
	NrioStuff.load("blind_edition")("blind_editions", {
		"positive",
		"divinatory",
		"galactic",
		"prismatic"
	})
end

if ns_config["Decks and Sleeves"] then
	NrioStuff.load("deck")("decks", {
  		"turquoise",
  		"concert",
  		"abstract",
		--"formulaic",
	})
end

if ns_config["Decks and Sleeves"] and CardSleeves then
	NrioStuff.load("card_sleeve")("card_sleeves", {
  		"turquoise",
  		"concert",
  		"abstract" 
	})
end

if ns_config["Jokers :D"] then
	NrioStuff.load("joker")("jokers", {
		"clown",
		"altruistic",
		"frail",
		"peaceful",
   		"abstemious",
		"funny",
   		"absurd",
		"annoyed",
		"lunatic",
		"amusing",
		"brilliant",
		"ingenuous",
		"artless",
		"ignorant",
		"straightforward",
		"roughness",
		"lone",
   		"mismatch",
   		"stumble",
   		"baba",
		"keke",
   		"fofo",
   		"jiji",
	})
end

if ns_config["Consumable!!!!"] then
	NrioStuff.load("consumable")("consumables", {
  		"rune",
	})
end

NrioStuff.load("sticker")("stickers", {
  		"yhtnsmod",
})

local usingMoreFluff=SMODS.Mods and SMODS.Mods["MoreFluff"] and SMODS.Mods["MoreFluff"].can_load or false
local usingortalab=SMODS.Mods and SMODS.Mods["ortalab"] and SMODS.Mods["ortalab"].can_load or false
if usingMoreFluff and ns_config["Collabs Editions"] then
	NrioStuff.load("edition")("editions", {
		"pdbfrrep",
		"vivid"
	})
end
if usingortalab and ns_config["Collabs Editions"] then
	NrioStuff.load("edition")("editions", {
		"stellar",
		"fortuitous"
	})
end

function SMODS.current_mod.reset_game_globals() 
  for key, value in pairs(NrioStuff.round_vars) do
    G.GAME.current_round["ns_" .. key] = value(G.GAME.current_round["ns_" .. key])
  end
end
