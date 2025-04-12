local s = {
  loc_txt = {
    name = "Perthro",
    text = {
      "{C:attention}Reroll{} Boss Blind"
    },
  },
  config = {},
  atlas = 6,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = {} }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

function s:use(card)
   G.from_boss_tag = true
   G.FUNCS.reroll_boss()
   G.from_boss_tag = nil
end

return s
