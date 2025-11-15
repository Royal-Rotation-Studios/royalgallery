SMODS.Joker {
    key = "under_paid",
    config = { extra = { money = 4 } },
    pos = { x = 5, y = 0 },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'jokers',
    soul_pos = nil,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money }, key = self.key }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            if G.GAME.current_round.hands_played == 1 then
                ease_dollars(card.ability.extra.money or 10)
                local msg = "+$" .. tostring(card.ability.extra.money or 4)
                return { 
                    message = msg, 
                    colour = G.C.DOLLAR
                }
            end
        end
    end
}
