class CreatePawns < ActiveRecord::Migration[7.0]
  def change
    create_table :pawns do |t|
      t.integer :x
      t.integer :y
      t.string :face
      t.string :color

      t.timestamps
    end
  end
end
