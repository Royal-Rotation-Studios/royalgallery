SMODS.Joker{
    key = "sample_specifichand",
    config = { extra = { poker_hand = "Five of a Kind", x_chips = 500000000 } },
    pos={ x = 0, y = 0 },
    rarity = 3,
    cost = 10,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    effect=nil,
    soul_pos=nil,
    atlas = 'sample_specifichand',

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            if context.scoring_name == card.ability.extra.poker_hand then
                return {
                    message = localize{type='variable',key='a_xchips',vars={card.ability.extra.x_chips}},
                    colour = G.C.BLUE,
                    x_chips = card.ability.extra.x_chips
                }
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.poker_hand, card.ability.extra.x_chips }, key = self.key }
    end        
}