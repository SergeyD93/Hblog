class CreateComments < ActiveRecord::Migration
  def change
    t.text :body
    t.foreign_key :article
    t.foreign_key :user
    t.foreign_key :parent_comment

    t.timestamps null: false
  end
end
