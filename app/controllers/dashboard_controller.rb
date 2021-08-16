class DashboardController < ApplicationController
    def show
        event_ids = Event.joins(:users).where("users.username IN (?) ", group).ids
        @group_events = Event.where(id: event_ids)

        amount_earned = 0
        earnings_total = 0
        delivery_fees_total = 0

        @group_events.each do |event|
            amount_earned = amount_earned + event.earnings_per_group
            earnings_total = earnings_total + event.earnings_per_group

            if group.include?(event.delivery_driver)
                amount_earned = amount_earned + event.delivery_fee
                delivery_fees_total = delivery_fees_total + event.delivery_fee
            end
        end

        dashboard = {
            group: {
                name: group.join(" & "),
                amount_earned: amount_earned,
                earnings_total: earnings_total,
                delivery_fees_total: delivery_fees_total,
                events: @group_events
            },
        }

        @all_events = Event.all
        dashboard[:total_revenue] = 0
        dashboard[:total_delivery_fees] = 0
        dashboard[:total_earnings] = 0
        dashboard[:total_event_costs] = 0
        dashboard[:total_business_account] = 0
        dashboard[:total_paid_out_earnings] = 0
        dashboard[:total_unpaid_earnings] = 0
        dashboard[:total_tax] = 0

        @all_events.each do |event|
            dashboard[:total_revenue] = dashboard[:total_revenue] + (event.revenue || 0)
            dashboard[:total_business_account] = dashboard[:total_business_account] + (event.business_account_amount || 0)
            dashboard[:total_event_costs] = dashboard[:total_event_costs] + calculate_event_cost(event)
            dashboard[:total_delivery_fees] = dashboard[:total_delivery_fees] + (event.delivery_fee || 0)
            dashboard[:total_earnings] = dashboard[:total_earnings] + (event.earnings || 0)
            dashboard[:total_tax] = dashboard[:total_tax] + (event.tax_flat_fee || 0)

            event.is_paid_out ? 
                dashboard[:total_paid_out_earnings] = dashboard[:total_paid_out_earnings] + (event.earnings || 0) :  
                dashboard[:total_unpaid_earnings] = dashboard[:total_unpaid_earnings] + (event.earnings || 0)
        end



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

    def calculate_event_cost(event)
        if event.event_cost_flat_fee
             event.event_cost_flat_fee
        elsif event.event_cost_percentage
            (event.revenue * event.event_cost_percentage) / 100
        else
            0
        end
    end
end
