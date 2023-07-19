class CreateTutors < ActiveRecord::Migration[7.0]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tutors, :email, unique: true
  end
end
