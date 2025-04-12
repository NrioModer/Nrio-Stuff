local s = {
  loc_txt = {
    name = "Ansuz",
    text = {
      "Go to a {C:attention}Shop"
    },
  },
  config = {},
  atlas = 8,
}

function s:loc_vars(infoq, card)
  infoq[#infoq + 1] = { key = "ns_rune", set = "Other" }
  return { vars = {} }
end

function s:can_use(card)
  return G.STATE and G.STATE == G.STATES.BLIND_SELECT 
end

G.FUNCS.shopping = function(e) 
            if G.blind_select then 
                    G.blind_select:remove()
                    G.blind_prompt_box:remove()
                    G.blind_select = nil
                end
                local prev_state = G.STATE
                G.GAME.current_round.jokers_purchased = 0
                G.GAME.current_round.used_packs = {}
                local chaos = find_joker('Chaos the Clown')
                G.GAME.current_round.free_rerolls = #chaos
                G.GAME.current_round.free_rerolls = G.GAME.current_round.free_rerolls + (G.GAME.current_round.ortalab_rerolls or 0)
                G.GAME.round_resets.temp_reroll_cost = nils
                G.GAME.current_round.reroll_cost_increase = 0
                calculate_reroll_cost(true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    blocking = false,
                    func = function()
                    if #G.E_MANAGER.queues.base > 2 or G.GAME.PACK_INTERRUPT then return false end
                        G.STATE = G.STATES.SHOP
                        G.STATE_COMPLETE = false
                        return true
                    end
                }))
            	G:update_shop(dt)
end

function s:use(card)
   G.from_boss_tag = true
   G.FUNCS.shopping()
   G.from_boss_tag = nil
end

return s
