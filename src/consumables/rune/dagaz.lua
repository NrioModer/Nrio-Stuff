local s = {
  loc_txt = {
    name = "Dagaz",
    text = {
      "When next blind begins, gives",
      "{C:dark_edition}tag{} that was on this Blind",
      "{C:inactive}(Currently {C:dark_edition}+#2#{C:inactive})",
    },
  },
  config = { extra = 4 },
  atlas = 4,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = { card.ability.extra, G.GAME.used_dagaz or 0 } }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

function s:use(card)
  if not G.GAME.used_dagaz then
	G.GAME.used_dagaz = 0
  end
  G.GAME.used_dagaz = G.GAME.used_dagaz + 1
end

return s
