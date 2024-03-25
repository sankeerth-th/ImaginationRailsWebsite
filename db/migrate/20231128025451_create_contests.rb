class CreateContests < ActiveRecord::Migration[7.0]
  def change
    create_table :contests do |t|
      t.string :title
      t.text :desc

      t.timestamps
    end
  end
end
