local j = {
  loc_txt = {
    name = "Brilliant Clown",                                   
        text = {
		"Played cards have a",
		"{C:green}#1# in #2#{} chance to give {C:money}$#3#{}",     
        },
  },
  config = {extra = {chance = 4, money = 1}},
  rarity = 1,
  cost = 5,
  atlas = 30,
  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {G.GAME.probabilities.normal, card.ability.extra.chance, card.ability.extra.money} }
end


function j:calculate(card, context)
    if context.individual and context.cardarea == G.play then
	if pseudorandom(pseudoseed('honest')) < G.GAME.probabilities.normal / card.ability.extra.chance then
                return {
                    dollars = card.ability.extra.money,
                    card = card
                }
        end
    end
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_ignorant"] = {
    text = {
            { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
            { text = "x",                              scale = 0.35 },
            { text = "$",                             colour = G.C.GOLD },
	    { ref_table = "card.joker_display_values", colour = G.C.GOLD , ref_value = "money", retrigger_type = "mult" },
        },
        extra = {
            {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "odds" },
                { text = ")" },
            }
        },
        extra_config = { colour = G.C.GREEN, scale = 0.3 },
        calc_function = function(card)
            local count = 0
            local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    count = count +
                            JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                end
            end
            card.joker_display_values.count = count
	    card.joker_display_values.money = card.ability.extra.money
            card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.chance } }
        end
    }
end
	
return j
