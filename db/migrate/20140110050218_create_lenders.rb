class CreateLenders < ActiveRecord::Migration

  def self.up
    create_table :lenders do |t|
      t.string :name
      t.string :date_of_lending
      t.timestamps
    end

    def self.down
      drop_table :lenders
    end
  end
end
