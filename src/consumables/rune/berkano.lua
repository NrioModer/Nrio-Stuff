local s = {
  loc_txt = {
    name = "Berkano",
    text = {
      "Skipped blind",
      "gains {C:money}$#1#",
      "{C:inactive}(Currently {C:money}$#2#{C:inactive})",
    },
  },
  config = { extra = 3 },
  atlas = 7,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = { card.ability.extra, G.GAME.used_berkano or 0 } }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

function s:use(card)
  if not G.GAME.used_berkano then
	G.GAME.used_berkano = 0
  end
  G.GAME.used_berkano = G.GAME.used_berkano + card.ability.extra
end

return s
