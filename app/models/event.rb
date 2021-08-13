class Event < ApplicationRecord

    attribute :workers

    has_and_belongs_to_many :users

    before_save :perform_calculations

    private 
    def perform_calculations

        event_cost = self.event_cost_flat_fee || 0
        event_cost = self.revenue * self.event_cost_percentage / 100 if self.event_cost_percentage

        self.business_account_amount = (self.revenue - event_cost) / 2

        delivery_fee = self.delivery_fee || 0
        self.earnings = self.revenue - self.business_account_amount - event_cost - delivery_fee

        self.earnings_per_group = self.earnings / worker_groups.length
    end 

    def worker_groups
        groups = []

        worker_names = self.workers.map {|worker| worker.username }

        if worker_names.include?("Andrew") || worker_names.include?("Tayeesa")
            groups << "Andrew & Tayeesa"
        end

        if worker_names.include?("David") || worker_names.include?("Maryana")
            groups << "David & Maryana"
        end

        if worker_names.include?("Paul")
            groups << "Paul"
        end

        groups
    end
end
