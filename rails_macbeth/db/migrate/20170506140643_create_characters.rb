class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    # enable_extension :citext
    create_table :characters do |t|
      t.string :name

      t.timestamps
    end
  end
end
