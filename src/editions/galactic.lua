local function get_poker_hand()
  local poker_hands = {}
  local total_weight = 0
  for _, handname in ipairs(G.handlist) do
    if G.GAME.hands[handname].visible then
      local weight = G.GAME.hands[handname].played + 1
      total_weight = total_weight + weight
      poker_hands[#poker_hands + 1] = { handname, total_weight }
    end
  end

  local weight = pseudorandom("j_bplus_meteor_hand") * total_weight
  local hand
  for _, h in ipairs(poker_hands) do
    if weight < h[2] then
      hand = h[1]
      break
    end
  end

  return hand
end
SMODS.Sound{
	key = "galacticsound",
	path = "galactic.ogg"
}
SMODS.Shader{
	key = "galactic",
	path = "galactic.fs",
}
SMODS.Edition{
	key = "galactic",
	shader = "galactic",
	loc_txt = {
        	name="Galactic",
        	label='Galactic',
                	text = {
        			"Level up random",
				"{C:attention}poker hand{}"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 10,
	extra_cost = 3,
	sound = { sound = "ns_galacticsound", per = 1.2, vol = 0.9 },
	config = {},
	calculate = function(self, card, context)
	   if context.main_scoring and context.cardarea == G.play and not context.repetition then
		card.ability.level_up_random = card.ability.level_up_random or 0
            	card.ability.level_up_random = card.ability.level_up_random + 0.5
		if card.ability.level_up_random >= 1 then
			card.ability.level_up_random = 0
			local hand = get_poker_hand()
    			card_eval_status_text(card, "extra", nil, nil, nil, {
      				message = localize("k_level_up_ex"),
      				colour = G.C.GREEN,
    			})
			update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
      				handname = localize(hand, "poker_hands"),
      				chips = G.GAME.hands[hand].chips,
      				mult = G.GAME.hands[hand].mult,
      				level = G.GAME.hands[hand].level,
    			})
			level_up_hand(card, hand)
			update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = mult, chips = chips, handname = '', level = ''})
		end
            end
	    if context.pre_joker then
		local hand = get_poker_hand()
    		card_eval_status_text(card, "extra", nil, nil, nil, {
      			message = localize("k_level_up_ex"),
      			colour = G.C.GREEN,
    		})
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
      			handname = localize(hand, "poker_hands"),
      			chips = G.GAME.hands[hand].chips,
      			mult = G.GAME.hands[hand].mult,
      			level = G.GAME.hands[hand].level,
    		})
		level_up_hand(card, hand)
		update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = mult, chips = chips, handname = '', level = ''})
            end
	end
}