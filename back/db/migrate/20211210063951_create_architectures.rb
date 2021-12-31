class CreateArchitectures < ActiveRecord::Migration[6.1]
  def change
    create_table :architectures do |t|
      t.string :name
      t.string :prefecture
      t.string :address
      t.decimal :lat, precision: 11, scale: 8
      t.decimal :lng, precision: 11, scale: 8
      t.string :construction
      t.string :designer
      t.string :above_floor
      t.string :under_floor
      t.string :image

      t.index :name, unique: true

      t.timestamps
    end
  end
end
