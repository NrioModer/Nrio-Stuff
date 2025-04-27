local j = {
  loc_txt = {
    name = "Amusing Clown",                                   
        text = {
		"If played hand",
      		"contains a {C:attention}#3#{},",
		"Each played cards give",
      		"{C:chips}+#1#{} Chips or {C:mult}+#2#{} Mult"       
        },
  },
  config = {extra = {chips=20, mult=2, hand_type = 'Flush'}},
  rarity = 1,
  cost = 5,
  atlas = 7,
  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.chips, card.ability.extra.mult, localize(card.ability.extra.hand_type, 'poker_hands')} }
end


function j:calculate(card, context)
    if context.individual and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.hand_type])then
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
    JokerDisplay.Definitions["j_ns_amusing"] = {
    text = {
      { text = "+", colour = G.C.CHIPS },
      { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
      { text = "/", colour = G.C.INACTIVE },
      { text = "+", colour = G.C.MULT },
      { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
    },
    reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
            { text = ")" },
        },
        calc_function = function(card)
            local mult = 0
	    local chips = 0
            local _, poker_hands, _ = JokerDisplay.evaluate_hand()
            if poker_hands[card.ability.extra.hand_type] and next(poker_hands[card.ability.extra.hand_type]) then
                mult = card.ability.extra.mult
		chips = card.ability.extra.chips
            end
            card.joker_display_values.mult = mult
            card.joker_display_values.chips = chips
            card.joker_display_values.localized_text = localize(card.ability.extra.hand_type, 'poker_hands')
	end
  }
end
	
return j
