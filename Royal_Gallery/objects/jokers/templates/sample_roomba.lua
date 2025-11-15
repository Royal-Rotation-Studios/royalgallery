SMODS.Joker{
    key = "sample_roomba",
    config={ },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'sample_roomba',
    soul_pos = nil,

        calculate = function(self, card, context)
        if context.end_of_round and not (context.individual or context.repetition) then
            local cleanable_jokers = {}

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= self then -- if joker is not itself 
                    cleanable_jokers[#cleanable_jokers+1] = G.jokers.cards[i] -- add all other jokers into a array
                end
            end

            local joker_to_clean = #cleanable_jokers > 0 and pseudorandom_element(cleanable_jokers, pseudoseed('clean')) or nil -- pick a random valid joker, or null if no valid jokers

            if joker_to_clean then -- if we have a valid joker we can bump into
                shakecard(joker_to_clean) -- simulate bumping into a card
                if(joker_to_clean.edition) then --if joker has an edition
                    if not joker_to_clean.edition.negative then --if joker is not negative
                        joker_to_clean:set_edition(nil) -- clean the joker from it's edition
                    end
                end
            end
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { }
    end
}