SMODS.Joker{
    key = "sample_obelisk",
    config = { extra = { x_mult = 0.1 } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sample_obelisk',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers and context.scoring_name then
            local current_hand_times = (G.GAME.hands[context.scoring_name].played or 0) -- how many times has the player played the current type of hand. (pair, two pair. etc..)
            local current_xmult = 1 + (current_hand_times * card.ability.extra.x_mult)
            
            return {
                message = localize{type='variable',key='a_xmult',vars={current_xmult}},
                colour = G.C.RED,
                x_mult = current_xmult
            }

            -- you could also apply it to the joker, to do it like the sample wee, but then you'd have to reset the card and text every time the previewed hand changes.
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult }, key = self.key }
    end
}