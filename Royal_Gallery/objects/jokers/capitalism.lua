SMODS.Joker{
    key = "capitalism",
    config = { extra = { required_rank = 8, cash_reward = 10, passed = false, processed_round = -1, fail_cost = 3 } },
    pos = { x = 0, y = 2 },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    atlas = 'jokers',
    soul_pos = nil,

    calculate = function(self, card, context)
        -- 1) During the scoring pass: evaluate the just-scored hand and store result
        if context.joker_main and context.cardarea == G.jokers and context.scoring_hand and not context.blueprint then
            local required = card.ability.extra.required_rank or 8
            local all_above = true

            for _, played in ipairs(context.scoring_hand) do
                if played:get_id() <= required then
                    all_above = false
                    break
                end
            end

            card.ability.extra.passed = all_above
            return nil
        end

        -- 2) At end of round: apply result once, once-per-round
        if context.end_of_round and not context.blueprint then
            local current_round = (G.GAME and G.GAME.round) or -1

            -- guard: only process once per round (prevents multiple jokers / multiple triggers)
            if card.ability.extra.processed_round == current_round then
                return nil
            end
            card.ability.extra.processed_round = current_round

            -- success path
            if card.ability.extra.passed then
                ease_dollars(card.ability.extra.cash_reward or 10)
                -- prepare message
                local msg = "+$" .. tostring(card.ability.extra.cash_reward or 10) .. "!"
                -- prepare for next round: randomize required rank (2..10)
                card.ability.extra.required_rank = math.random(2, 10)
                card.ability.extra.passed = false

                return { message = msg, colour = G.C.DOLLAR }
            end

            --Take $3
            G.GAME.dollars = (G.GAME.dollars or 0) - card.ability.extra.fail_cost
            local msg = "-$" .. tostring(card.ability.extra.fail_cost or 3) .. "!"
            play_sound('tarot1', 0.9)

            --Randomize requirement for next round
            card.ability.extra.required_rank = math.random(2, 10)
            card.ability.extra.passed = false

            return { message = msg, colour = G.C.RED }
        end

        return nil
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.required_rank, card.ability.extra.cash_reward, card.ability.extra.fail_cost }, key = self.key }
    end
}