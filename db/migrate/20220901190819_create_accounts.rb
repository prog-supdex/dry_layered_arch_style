# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :accounts do
      primary_key :id
      column :name, String, null: false
      column :balance, Bignum, default: 0, null: false
      column :status, String, default: "active"

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      check(status: %w[active blocked])
    end
  end
end
