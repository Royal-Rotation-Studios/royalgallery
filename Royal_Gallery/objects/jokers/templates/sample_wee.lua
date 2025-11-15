SMODS.Joker{
    key = "sample_wee",                                  --name used by the joker.    
    config = { extra = { chips = 8, chip_mod = 2 } },    --variables used for abilities and effects.
    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                            --cost to buy the joker in shops.
    blueprint_compat=true,                               --does joker work with blueprint.
    eternal_compat=true,                                 --can joker be eternal.
    unlocked = true,                                     --is joker unlocked by default.
    discovered = true,                                   --is joker discovered by default.    
    effect=nil,                                          --you can specify an effect here eg. 'Mult'
    soul_pos=nil,                                        --pos of a soul sprite.
    atlas = 'sample_wee',                                --atlas name, single sprites are deprecated.

    calculate = function(self,card,context)              --define calculate functions here
        if context.individual and context.cardarea == G.play then -- if we are in card scoring phase, and we are on individual cards
            if not context.blueprint then -- blueprint/brainstorm don't get to add chips to themselves
                if context.other_card:get_id() == 2 then -- played card is a 2 by rank
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod -- add configurable amount of chips to joker
                    
                    return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
                        extra = {focus = card, message = localize('k_upgrade_ex')},
                        card = card,
                        colour = G.C.CHIPS
                    }
                end
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {                                     -- returns total chips from joker to be used in scoring, no need to show message in joker_main phase, game does it for us.
                chips = card.ability.extra.chips, 
                colour = G.C.CHIPS
            }
        end
    end,

    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod }, key = self.key }
    end
}