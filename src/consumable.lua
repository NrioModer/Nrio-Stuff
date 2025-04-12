return function(consumable_dir, consumables)
  for k, ct in pairs(consumables) do
    if type(ct) == "string" then
      if type(k) == "number" then
        k = ct
      end
      ct = NrioStuff.load(consumable_dir .. "/" .. ct) or ct
    end
    if type(ct) == "table" then
      ct.key = k
      if not ct.collection_rows then
        ct.collection_rows = { 5, 5 }
      end

      local has_atlas
      if ct.atlas then
        has_atlas = true
        SMODS.Atlas {
          key = ct.key,
          path = ct.atlas,
          px = ct.atlas_px or 71,
          py = ct.atlas_py or 95,
        }
        ct.atlas_px = nil
        ct.atlas_py = nil
        ct.atlas = nil
      end

      if type(ct.cards) == "table" then
        local dir = ct.cards.dir or ("consumables/" .. k)
        local prefix = ct.cards.key_prefix or ct.key

        local cards = {}
        for _, card_key in ipairs(ct.cards) do
          local c = NrioStuff.load(dir .. "/" .. card_key)
          local key = prefix .. "_" .. card_key
          local _key = "c_ns_" .. key

          c.set = ct.key
          c.key = key
          c.cost = c.cost or 6

          if type(c.unlocked) ~= "boolean" then
            c.unlocked = true
          end

          if type(c.atlas) == "number" then
            local n = c.atlas
            c.atlas = ct.key
            local x = n % 5
            if x == 0 then
              x = 5
            end
            c.pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
          elseif has_atlas then
            c.atlas = ct.key
          end

          c.discovered = false
          SMODS.Consumable(c)

          cards[_key] = true
        end
        ct.cards = cards
      end

      SMODS.ConsumableType(ct)
    end
  end
end
