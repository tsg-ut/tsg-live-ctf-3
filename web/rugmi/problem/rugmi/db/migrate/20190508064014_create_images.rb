class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :filename
      t.boolean :is_public

      t.timestamps
    end
  end
end
