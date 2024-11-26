class Share < ApplicationRecord
  belongs_to :user
  belongs_to :receiver, class_name: "User"
  belongs_to :recipe
end
# share.user , share.receiver, share.recipe => renvoient instances