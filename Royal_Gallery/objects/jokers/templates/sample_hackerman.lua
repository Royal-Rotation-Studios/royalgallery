SMODS.Joker{
    key = "sample_hackerman",
    config = { repetitions = 1 },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sample_hackerman',
    soul_pos = nil,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and (
            context.other_card:get_id() == 6 or 
            context.other_card:get_id() == 7 or 
            context.other_card:get_id() == 8 or 
            context.other_card:get_id() == 9) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.repetitions,
                card = self
            }
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end
}