class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.foreign_key :article
      t.foreign_key :user
      t.foreign_key :parent_comment

      t.timestamps null: false
    end
  end
end
