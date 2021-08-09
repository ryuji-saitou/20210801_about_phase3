class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :user_id      , null: false
      t.string  :post_image_id
      t.text    :action       , null: false
      t.integer :time_required, null: false
      t.integer :budget       , null: false
      t.boolean :is_hided     , null: false, default: false

      t.timestamps
    end
  end
end