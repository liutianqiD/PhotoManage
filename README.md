# README
* ローカル動作確認環境
  * Ruby version: 2.7.2
  * CentOS Linux release 8.1.1911 (Core)

* ローカル動く手順
  * $ bundle install
  * $ bundle exec rails db:migrate
  * ログインユーザ手動登録
    * $ bundle exec rails c
      * User.create(email: "hogehoge@example.com", password: "hogehoge", password_confirmation: "hogehoge")
  * 起動
    * $ bundle exec rails s
