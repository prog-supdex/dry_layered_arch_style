# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :tests do
      primary_key :id
      column :comment, String, text: true
      column :status, String, default: "pending"
      foreign_key :toy_id, :toys, unique: true
      foreign_key :account_id, :accounts
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :account_id
      index :toy_id

      check(status: %w[pending approved declined])
    end
  end
end
