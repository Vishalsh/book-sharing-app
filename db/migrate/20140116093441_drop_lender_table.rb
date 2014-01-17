class DropLenderTable < ActiveRecord::Migration

  def self.up
    drop_table :lenders
  end

  def self.down
    create_table :lenders do |t|
      t.string :name
      t.string :date_of_lending
      t.timestamps
    end

  end
end
