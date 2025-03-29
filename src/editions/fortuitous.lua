SMODS.Sound{
	key = "divinatorysound",
	path = "divinatory.ogg"
}
SMODS.Shader{
	key = "fortuitous",
	path = "fortuitous.fs",
}
SMODS.Edition{
	key = "fortuitous",
	shader = "fortuitous",
	loc_txt = {
        	name="Fortuitous",
        	label='Fortuitous',
                	text = {
        			"Turn random",
				"{C:attention}Consumable{} into",
				"a random {C:loteria}Loteria{}"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 12,
	extra_cost = 3,
	sound = { sound = "ns_divinatorysound", per = 1.2, vol = 1.5 },
	config = {},
	calculate = function(self, card, context)
	    if context.main_scoring and context.cardarea == G.play and not context.repetition then
		card.ability.lot_create = card.ability.lot_create or 0
            	card.ability.lot_create = card.ability.lot_create + 0.5
		if card.ability.lot_create >= 1 then
			play_sound('tarot1')
			card.ability.lot_create = 0
                	local destructable_consumeables = {}
                	for i = 1, #G.consumeables.cards do
                    		if not G.consumeables.cards[i].getting_replaced then destructable_consumeables[#destructable_consumeables+1] = G.consumeables.cards[i] end
                	end
                	local consumeables_to_replace = #destructable_consumeables > 0 and pseudorandom_element(destructable_consumeables, pseudoseed('madness')) or nil
			if consumeables_to_replace then
				consumeables_to_replace.getting_replaced = true
				consumeables_to_replace:start_dissolve(nil, false)
				local card = create_card('Loteria',G.consumeables, nil, nil, nil, nil, nil, 'car')
                        	card:add_to_deck()
                        	G.consumeables:emplace(card)
                        	G.GAME.consumeable_buffer = 0
			end
		end
            end
	    if context.pre_joker then
		local destructable_consumeables = {}
                for i = 1, #G.consumeables.cards do
                    if not G.consumeables.cards[i].getting_replaced then destructable_consumeables[#destructable_consumeables+1] = G.consumeables.cards[i] end
                end
                local consumeables_to_replace = #destructable_consumeables > 0 and pseudorandom_element(destructable_consumeables, pseudoseed('madness')) or nil
		if consumeables_to_replace then
			consumeables_to_replace.getting_replaced = true
			consumeables_to_replace:start_dissolve(nil, false)
			local card = create_card('Loteria',G.consumeables, nil, nil, nil, nil, nil, 'car')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
			return {
                		message = localize('ortalab_config_loteria_skip'),
				colour = G.C.PURPLE
            		}
		end	
            end
	end
}