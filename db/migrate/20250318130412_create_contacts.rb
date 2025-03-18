class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.text :name
      t.text :email

      t.timestamps
    end

    add_index :contact, :email, unique: true
  end
end
