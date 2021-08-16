class TransactionsController < ApplicationController
    require 'plaid'

    def index
        transactions = get_transactions
        already_imported_transaction_ids = Expense.pluck(:plaid_transaction_id)

        render json: transactions
    end

    private
    def api
        Plaid::Client.new(env: :development, client_id: ENV["PLAID_CLIENT_ID"], secret: ENV["PLAID_SECRET"])
    end

    def access_token
        ENV["PLAID_ACCESS_TOKEN"]
    end

    def chase_account
        [ENV["CHASE_ACCOUNT_ID"], ENV["CHASE_ACCOUNT_ID_2"]]
    end

    def get_transactions
        transactions_response = api.transactions.get(access_token, 12.months.ago, Time.now, account_ids: chase_account, count: 500)
        transactions_response.transactions
    end
end
