class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|

      t.string :name           , null: false
      t.string :email          , null: false
      t.string :phone_number   , null: false
      t.string :subject        , null: false
      t.text   :contact_message, null: false

      t.timestamps
    end
  end
end
