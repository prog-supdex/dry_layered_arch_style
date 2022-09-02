# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :toys do
      primary_key :id
      column :name, String, null: false
      column :status, String, default: "init", null: false
      column :characteristics, String, null: false, text: true
      column :characteristic_type, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      check(status: %w[init in_testing declined approved])
      check(characteristic_type: %w[happines playful afeties brightness])
    end
  end
end
