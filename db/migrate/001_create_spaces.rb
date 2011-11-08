class CreateSpaces < ActiveRecord::Migration
  def self.up
    create_table :spaces do |t|
      t.string :fb_id
      t.string :space_id
      t.string :token
    end
  end

  def self.down
    drop_table :spaces
  end
end
