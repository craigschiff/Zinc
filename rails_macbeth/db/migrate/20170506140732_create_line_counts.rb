class CreateLineCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :line_counts do |t|
      t.belongs_to :character, foreign_key: true
      t.belongs_to :version, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
