class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :channel_id
      t.timestamps
      
    end
  end
end
