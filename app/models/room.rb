class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end

#3 room_users中間テーブルを経由して、roomモデルから見てuserモデルと一対多でアソシエーションし、roomテーブルのレコードが削除された時、それに紐づくuserも一緒に削除する
#4 roomテーブルのレコードが削除された時、それに紐づくmessagesも一緒に削除する