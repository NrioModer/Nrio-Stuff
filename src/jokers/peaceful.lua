local j = {
  loc_txt = {
    name = "Peaceful Clown",                                   
        text = {
		"Played cards with non-{C:spades}Spade{} suit",
                "gives {C:mult}+#1#{} Mult when scored,",
		"while a {C:spades}Spade{} card destroys joker", 
        },
  },
  config = {extra = {ns_mult = 3}},
  rarity = 1,
  cost = 5,
  atlas = 19,
  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {card.ability.extra.ns_mult} }
end


function j:calculate(card, context)
    if context.individual and context.cardarea == G.play and not card.getting_sliced then
		if context.other_card:is_suit("Spades") then
			 card.getting_sliced = true
                    	 return {
                            extra = {focus = card, message = localize('k_extinct_ex'), func = function()
                                G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.0, blockable = false,
                                        func = function()
                                                G.jokers:remove_card(card)
                                                card:remove()
                                                card = nil
                                            return true; end})) 
                                    return true
                                  end
                            	}))
                            end},
                            card = card
                        }
        	elseif not context.other_card.debuff then
                    	return {
                        	mult = card.ability.extra.ns_mult,
                        	card = card
                    	}
        	end
    	end
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_peaceful"] = {
    	text = {
            { text = "+" },
            { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
        },
        text_config = { colour = G.C.MULT },
        reminder_text = {
            { text = "(non-" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Spades"], 0.35) },
            { text = ")" }
        },
        calc_function = function(card)
            local mult = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card:is_suit("Spades") then
			local destroyed = true
			break
		    elseif not scoring_card.debuff and not destroyed then
		    	mult = mult +
                            card.ability.extra.ns_mult * JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
		    end
                end
            end
            card.joker_display_values.mult = mult
            card.joker_display_values.localized_text = localize("Spades", 'suits_plural')
        end
    }
end
	
return j
