class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.references :campaign, foreign_key: true
      t.boolean :open
      t.string :token

      t.timestamps
    end
  end
end
