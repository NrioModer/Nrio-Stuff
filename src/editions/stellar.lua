SMODS.Sound{
	key = "stellarsound",
	path = "stellar.ogg"
}
SMODS.Shader{
	key = "stellar",
	path = "stellar.fs",
}
SMODS.Edition{
	key = "stellar",
	shader = "stellar",
	loc_txt = {
        	name="Stellar",
        	label='Stellar',
                	text = {
        			"Create the {C:zodiac}Zodiac Card{} for", 
				"the {C:attention}poker hand{} if played",
				"{C:attention}poker hand{} is a {C:attention}#1#{}",
				"{C:inactive}(Must have room)"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 9,
	extra_cost = 4,
	sound = { sound = "ns_stellarsound", per = 1.2, vol = 0.9 },
	config = {poker_hand = 'Straight Flush'},
	loc_vars = function(self, info_queue, card, area)
		return {
			vars = {
				localize(card.edition.poker_hand, 'poker_hands')
			},
		}
	end,
	calculate = function(self, card, context)
	   if context.main_scoring and context.cardarea == G.play and not context.repetition and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		card.ability.zodiac_create = card.ability.zodiac_create or 0
            	card.ability.zodiac_create = card.ability.zodiac_create + 0.5
		if card.ability.zodiac_create >= 1 then
			card.ability.zodiac_create = 0
			if context.scoring_name == card.edition.poker_hand then
				local zodiac_key = zodiac_from_hand(context.scoring_name)
                		local new_zodiac = create_card("Zodiac", G.consumeables, nil, nil, true,  true, zodiac_key)
                		new_zodiac:add_to_deck()
                		G.consumeables:emplace(new_zodiac)
                		new_zodiac:juice_up()
				return {
                			message = localize('ortalab_zodiac_add'),
					colour = G.C.PURPLE
            			}
			end
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible then _poker_hands[#_poker_hands+1] = k end
			end
			card.edition.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('STELLAR'))
		end
            end
	    if context.pre_joker and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		if context.scoring_name == card.edition.poker_hand then
			local zodiac_key = zodiac_from_hand(context.scoring_name)
                	local new_zodiac = create_card("Zodiac", G.consumeables, nil, nil, true,  true, zodiac_key)
                	new_zodiac:add_to_deck()
                	G.consumeables:emplace(new_zodiac)
                	new_zodiac:juice_up()
			return {
                		message = localize('ortalab_zodiac_add'),
				colour = G.C.PURPLE
            		}
		end
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then _poker_hands[#_poker_hands+1] = k end
		end
		card.edition.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('STELLAR'))
            end
	end
}