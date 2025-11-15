SMODS.Joker {
    key = "numerophobia",
    config = { extra = { consumable_amount = 2 } },
    pos = { x = 4, y = 2 },
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
        return { vars = { card.ability.extra.consumable_amount }, key = self.key }
    end,

    calculate = function(self, card, context)
        if not context.blueprint and context.after and context.main_eval then
            local destroyed_cards = {}

            for _, v in ipairs(G.play.cards) do
                destroyed_cards[#destroyed_cards + 1] = v
            end

            -- Destroy all cards in first hand
            if G.GAME.current_round.hands_played == 0 then
                SMODS.destroy_cards(destroyed_cards)

                return {
                    message = 'Destroyed!',
                    colour = G.C.MULT
                }
            end
        end

        if context.joker_main then
            local amount = tonumber(card.ability.extra.consumable_amount) or 1
            if amount < 1 then amount = 1 end

            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    for i = 1, amount do
                        local _card = create_card('Tarot',G.consumeables,nil,nil,nil,nil,nil,'vag')
                        if _card then
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            --G.GAME.consumeable_buffer = 0
                        end
                    end
                    G.GAME.consumeable_buffer = 0
                    return true
                end)
            }))
            return {
                message = localize('k_plus_tarot'),
                card = card
            }
        end
    end
}
