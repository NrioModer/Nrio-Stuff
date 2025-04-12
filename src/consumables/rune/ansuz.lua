local s = {
  loc_txt = {
    name = "Ansuz",
    text = {
      "{C:attention}Reroll{} all Tags"
    },
  },
  config = {},
  atlas = 5,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = {} }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

G.FUNCS.reroll_tags = function(e) 
        stop_use()
        if G.GAME.round_resets.blind_states.Small ~= 'Defeated' then 
            G.GAME.round_resets.blind_tags.Small = get_next_tag_key()
        end
        if G.GAME.round_resets.blind_states.Big ~= 'Defeated' then
	   G.GAME.round_resets.blind_tags.Big = get_next_tag_key()
        end
        local random_tag_key = get_next_tag_key()
        while random_tag_key == 'tag_boss' do
            random_tag_key = get_next_tag_key()
        end
        if not G.GAME.orbital_choices[G.GAME.round_resets.ante][type] then -- from bettma mod (super dyper cool mod)
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands+1] = k end
            end
            
            G.GAME.orbital_choices[G.GAME.round_resets.ante]['Small'] = pseudorandom_element(_poker_hands, pseudoseed('orbital'))
        end
        local random_tag=Tag(random_tag_key,false,'Small')
        if G.blind_select then G.blind_select:remove() end
        G.blind_prompt_box:remove()
        G.blind_select = nil
        G.STATE_COMPLETE=false
end

function s:use(card)
   G.from_boss_tag = true
   G.FUNCS.reroll_tags()
   G.from_boss_tag = nil
end

return s
