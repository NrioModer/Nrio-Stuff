local j = {
  loc_txt = {
    name = "The Stumble",                                   
        text = {
            "{X:mult,C:white} X#1# {} Mult",
	    "Every poker hand",
	    "contains a {C:attention}Straight{}"                    
        },
  },
  config = {extra = {x_mult = 1/3}},
  rarity = 2,
  cost = 7,
  atlas = 124,
  blueprint_compat = false,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.x_mult} }
end


function j:calculate(card, context)
	if context.joker_main then
	    return {
        	message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
        	Xmult_mod = card.ability.extra.x_mult,
      	    }  
        end
end

local get_straight_OG = get_straight
function get_straight(hand)
	 local a = get_straight_OG(hand)
	 if next(find_joker("j_ns_stumble")) and #a == 0 then
		if #get_X_same(3,hand) ~= 0 then
			a = get_X_same(3,hand)
		elseif #get_X_same(2,hand) ~= 0 then
			a = get_X_same(2,hand)
		else
			a = get_highest(hand)
		end
	 end
	 return a
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_stumble"] = {
    	text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
	calc_function = function(card)
		card.joker_display_values.x_mult = card.ability.extra.x_mult
        end
    }
end
	
return j
