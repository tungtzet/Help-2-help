class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :bio
      t.string :address
      t.integer :age
      t.string :native_language
      t.string :second_language
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
