local j = {
  loc_txt = {
    name = "Clown",                                   
        text = {
		"Each played cards give",
      		"{C:chips}+#1#{} Chips or {C:mult}+#2#{} Mult"       
        },
  },
  config = {extra = {chips=5, mult=1}},
  rarity = 1,
  cost = 3,
  atlas = 1,
  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.chips, card.ability.extra.mult} }
end


function j:calculate(card, context)
    if context.individual and context.cardarea == G.play then
	local numbers = {"Mult", "Chips"}
	local result = pseudorandom_element(numbers)
	if result == "Mult" then
        	return {
          		mult = card.ability.extra.mult,
          		card = card
        	}
	else
        	return {
          		chips = card.ability.extra.chips,
          		card = card
        	}
	end
    end
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_clown"] = {
    text = {
      { text = "+", colour = G.C.CHIPS },
      { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
      { text = "/", colour = G.C.INACTIVE },
      { text = "+", colour = G.C.MULT },
      { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
    },
        calc_function = function(card)
            card.joker_display_values.mult = mult
            card.joker_display_values.chips = chips
	end
  }
end
	
return j
