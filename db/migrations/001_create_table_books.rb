# frozen_string_literal: true

Sequel.migration do
  change do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'

    create_table :books do
      uuid :id, primary_key: true, default: Sequel.function(:uuid_generate_v4)
      String :title, null: false
      String :author, null: false
      timestamptz :created_at, null: false, default: Sequel.function(:now)
      timestamptz :updated_at, null: false, default: Sequel.function(:now)
      index :title
      index :author
    end
  end
end
