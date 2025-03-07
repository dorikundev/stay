class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :address
      t.text :description
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end
end
