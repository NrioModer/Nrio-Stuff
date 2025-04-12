local s = {
  loc_txt = {
    name = "Hagalaz",
    text = {
      "Reduce this Blind and similar",
      "type of Blinds by {C:attention}#1#%",
      "{C:inactive}(Currently {C:attention}#2#%{C:inactive})",
    },
  },
  config = { extra = 20 },
  atlas = 2,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = { card.ability.extra, G.GAME.used_hagalaz or 100 } }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

function s:use(card)
  if not G.GAME.used_hagalaz then
	G.GAME.used_hagalaz = 100
  end
  G.GAME.used_hagalaz = G.GAME.used_hagalaz * (100-card.ability.extra) / 100
end

return s
