# frozen_string_literal: true

class RemoveImages < ActiveRecord::Migration[6.0]
  def up
    drop_table :images
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
