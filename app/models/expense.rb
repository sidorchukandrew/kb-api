class Expense < ApplicationRecord
    belongs_to :submitter, class_name: "User", foreign_key: :user_id
end
