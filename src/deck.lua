return function(deck_dir, decks)
  SMODS.Atlas {
    key = "decks",
    px = 71,
    py = 95,
    path = "decks.png",
  }

  for k, d in pairs(decks) do
    if type(d) == "string" then
      if type(k) == "number" then
        k = d
      end
      d = NrioStuff.load(deck_dir .. "/" .. d) or d
    end
    if type(d) == "table" then
      if type(d.atlas) == "number" then
        local n = d.atlas
        d.atlas = "decks"
        local x = n % 5
        if x == 0 then
          x = 5
        end
        d.pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
      end

      d.key = k
      if type(d.unlocked) ~= "boolean" then
        d.unlocked = true
      end
      d.discovered = false
      SMODS.Back(d)
    end
  end
end
