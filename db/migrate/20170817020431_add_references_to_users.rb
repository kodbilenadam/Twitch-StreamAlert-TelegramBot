class AddReferencesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :server, foreign_key: true
  end
end
