local s = {
  loc_txt = {
    name = "Ehwaz",
    text = {
      "When {C:attention}Blind{} is skipped,",
      "Creates a {C:dark_edition}Negative{} copy",
      "of {C:attention}#1#{} random {C:attention}consumable{}",
      "{C:inactive}(Currently {C:attention}#2#{C:inactive})",
    },
  },
  config = { extra = 1 },
  atlas = 3,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = { card.ability.extra, G.GAME.used_ehwaz or 0 } }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

function s:use(card)
  if not G.GAME.used_ehwaz then
	G.GAME.used_ehwaz = 0
  end
  G.GAME.used_ehwaz = G.GAME.used_ehwaz + card.ability.extra
end

return s
