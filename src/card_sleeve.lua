return function(card_sleeve_dir, card_sleeves)
  SMODS.Atlas {
    key = "card_sleeves",
    px = 73,
    py = 95,
    path = "card_sleeves.png",
  }

  for k, cs in pairs(card_sleeves) do
    if type(cs) == "string" then
      if type(k) == "number" then
        k = cs
      end
      cs = NrioStuff.load(card_sleeve_dir .. "/" ..cs) or cs
    end
    if type(cs) == "table" then
      if type(cs.atlas) == "number" then
        local n = cs.atlas
        cs.atlas = "card_sleeves"
        local x = n % 5
        if x == 0 then
          x = 5
        end
        cs.pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
      end

      cs.key = k
      if type(cs.unlocked) ~= "boolean" then
        cs.unlocked = true
      end
      cs.discovered = false
      CardSleeves.Sleeve(cs)
    end
  end
end
