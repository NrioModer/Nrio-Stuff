local s = {
  loc_txt = {
    name = "Jera",
    text = {
      "{X:money,C:white} X#1# {} the next",
      "Blind reward",
      "{C:inactive}(Currently {X:money,C:white}X#2#{C:inactive})",
    },
  },
  config = { extra = 3 },
  atlas = 1,
}

function dollars_to_string(dollars)
    if not dollars then
        return "-"
    end
    if dollars <= -9 then
        return "-$" .. tostring(-dollars)
    elseif dollars < 0 then
        return "-" .. string.rep("$", -dollars)
    elseif dollars >= 9 then
        return "$" .. tostring(dollars)
    elseif dollars > 0 then
        return string.rep("$", dollars)
    else
        return ""
    end
end

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = { card.ability.extra, G.GAME.used_jera or 1 } }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

function s:use(card)
  if not G.GAME.used_jera then
	G.GAME.used_jera = 1
  end
  G.GAME.used_jera = G.GAME.used_jera * card.ability.extra
end

return s
