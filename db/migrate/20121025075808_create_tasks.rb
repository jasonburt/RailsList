class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :notes
      t.boolean :status

      t.timestamps
    end
  end
end
