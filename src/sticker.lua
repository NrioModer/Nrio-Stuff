return function(sticker_dir, stickers)
  SMODS.Atlas {
    key = 'stickers',
    path = 'stickers.png',
    px = 71,
    py = 95
  }

  for k, st in pairs(stickers) do
    if type(st) == "string" then
      if type(k) == "number" then
        k = st
      end
      st = NrioStuff.load(sticker_dir .. "/" .. st) or st
    end
    if type(st) == "table" then
      if type(st.atlas) == "number" then
        local n = st.atlas
        st.atlas = "stickers"
        local x = n % 5
        if x == 0 then
          x = 5
        end
        st.pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
      end

      if type(st.soul_pos) == "number" then
        local n = st.soul_pos
        local x = n % 5
        if x == 0 then
          x = 5
        end
        st.soul_pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
      end

      st.key = k
      if type(st.unlocked) ~= "boolean" then
        st.unlocked = true
      end
      st.discovered = false
      SMODS.Sticker(st)
    end
  end
end
