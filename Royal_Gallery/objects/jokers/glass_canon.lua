SMODS.Joker {
    key = "glass_canon",
    config = { extra = { x_mult = 6, denom = 20 } },
    pos = { x = 4, y = 3 },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'jokers',
    soul_pos = nil,

    loc_vars = function(self, info_queue, card)
        local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.denom)
        return { vars = { card.ability.extra.x_mult, a, b }, key = self.key }
    end

    --NOT DONE
}
