class User < ApplicationRecord
    has_secure_password

    has_and_belongs_to_many :events

    has_many :expenses

    def first_login?
        self.number_of_logins <= 2
    end
end
