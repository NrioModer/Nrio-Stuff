baba_piece = {
	f = true,
	o = true,
}
local j = {
  loc_txt = {
    name = "Fofo is Clown",                                   
        text = {
		"Each played {C:attention}Queen{} or {C:attention}4{}",
                "gives {X:mult,C:white} X#1# {} Mult when scored",
        },
  },
  config = {extra = {xmult = 1.5}},
  rarity = 3,
  cost = 8,
  atlas = 83,
  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.xmult} }
end


function j:calculate(card, context)
    if context.individual and context.cardarea == G.play then
	if context.other_card:get_id() == 4 or context.other_card:get_id() == 12 or (G.GAME.akyrs_character_stickers_enabled and baba_piece[string.lower(context.other_card:get_letter_with_pretend())]) then
                    return {
                        x_mult = card.ability.extra.xmult,
                        card = card
                    }
        end
    end
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_fofo"] = {
    	text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "localized_text" },
        },
        calc_function = function(card)
            local count = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card:get_id() == 4 or scoring_card:get_id() == 12 or (G.GAME.akyrs_character_stickers_enabled and baba_piece[string.lower(scoring_card:get_letter_with_pretend())]) then
                        count = count +
                            JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    end
                end
            end
            card.joker_display_values.x_mult = card.ability.extra.xmult ^ count
            card.joker_display_values.localized_text = "(" .. localize("Queen", "ranks") .. ",4)"
        end
     }
end
	
return j
