class DashboardController < ApplicationController
    def show
        event_ids = Event.joins(:users).where("users.username IN (?) ", group).ids
        @events = Event.where(id: event_ids)

        amount_earned = 0
        earnings_total = 0
        delivery_fees_total = 0

        @events.each do |event|
            amount_earned = amount_earned + event.earnings_per_group
            earnings_total = earnings_total + event.earnings_per_group

            if group.include?(event.delivery_driver)
                amount_earned = amount_earned + event.delivery_fee
                delivery_fees_total = delivery_fees_total + event.delivery_fee
            end
        end

        dashboard = {
            events: @events,
            group: group.join(" & "),
            amount_earned: amount_earned,
            earnings_total: earnings_total,
            delivery_fees_total: delivery_fees_total
        }

        render json: dashboard
    end

    private
    def group
        names = []
        if @current_user.username == "David" || @current_user.username == "Maryana"
            names = ["David", "Maryana"]
        elsif   @current_user.username == "Andrew" || @current_user.username == "Tayeesa"
            names = ["Andrew", "Tayeesa"]
        elsif @current_user.username == "Paul"
            names = ["Paul"]
        end

        names
    end
end
