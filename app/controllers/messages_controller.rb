class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
  end
  #3 messageモデルからviewに渡す為インスタンスを生成して空のインスタンス変数にいれている
  #4 roomモデルからroom_idの入ったparams（indexviewから届けられたデータの中からroom_idを取り出し）をインスタンス変数に代入
  #5 1つのroom内（先程取り出したroom_idと同じroom）のmessageとそれに紐づくuserモデルの情報を取得しインスタンス変数に代入

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end
  # ? createアクション対応のviewは存在しないのになぜインスタンス変数を生成？各アクション毎に生成されたインスタンス変数は、対応のviewでしか使用できないはず・・？
  #↑ インスタンス変数にする理由はredirectでルーティングを介するためインスタンス変数でないと送れない。
  #12 roomモデルからroom_idの入ったパラメーターを取得しインスタンス変数へ代入（redirectするためインスタンス変数じゃないとだめ）
  #13 ？ _main_chatで入力された情報を、上で引っ張ってきたroomでの新しいmessageとしてインスタンス変数へ代入(@room.messagesは何を表す？Message.newではだめ？)
  #↑ Message.newでは、「どのルームのmessageとして保存する」のかがわからない。ルームを指定するために上で定義した変数を使う。この表記はアソシエーションしているから可能。
  #↑ permitでroom_idを取り出す方法を考えたが、requireで:messageを指定しているためそれも叶わない。
  #14 messageを保存しようとする時
  #15 保存できたらインスタンス変数を生成し、保存完了後の同じ部屋へリダイレクト
  #↑ redirect_toメソッドでmessagesコントローラーのindexアクションに再度リクエストを送信し、新たにインスタンス変数を生成。これによって保存後の情報に更新
  #17 ？ 保存できなかったら1つのroom内のmessageとそれに紐づくuserモデルの情報を取得しインスタンス変数に代入（投稿に失敗した@messagesの情報を保持しておくため？なぜ？）
  #18 一覧ページへ直行
  # indexへ直行＝indexアクションを介さない為、indexアクション内のインスタンス変数は全て用意しておく必要がある。＝indexアクション内の変数をこちらでも用意しないとエラーが出る
  # また、ルーティングを介するため持っていく情報はインスタンス変数にする必要がある




  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

end