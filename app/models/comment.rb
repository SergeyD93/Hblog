class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  has_many :answer_comments, class_name: "Comment",
           foreign_key: "parent_comment_id",
           dependent: :destroy

  belongs_to :parent_comment, class_name: "Comment"
end
