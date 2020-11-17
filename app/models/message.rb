class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    self.image.attached?
  end
end

#4 messageモデルの各レコードは、それぞれに1つずつimageファイルを添付することができる
#6 contentカラムが空で、was_attached? の結果がfalseならばバリデーションの検証を行う。
#8 was_attached?を定義
#9 レコードにimageファイルを添付しましたか？