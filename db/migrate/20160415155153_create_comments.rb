class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :article, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :parent_comment, index: true

      t.timestamps null: false
    end
  end
end
