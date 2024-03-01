# Name
 
勤怠管理アプリ
 
社員として登録した場合、出退勤の打刻や自身の勤怠記録が閲覧できる。
管理者として登録した場合は社員の登録情報や勤怠記録、労働状況などが閲覧できる。

# Production background

勤怠管理を紙ベースで行っていたが、残業時間の把握やデータ入力時のヒューマンエラーの発生、手間がかかりすぎる。加えて、リモート勤務も導入したため紙ベースでは難しくどこでも勤怠情報を入力するシステムを導入したいという企業の希望から作成。

# functions

・ユーザー認証<br>
・ログイン情報の保存<br>
・出退勤打刻<br>
・勤怠情報の削除・編集<br>
・勤怠情報の履歴閲覧<br>
・パスワードの変更<br>
・残業時間のアラート<br>
・社員の一覧表示<br>
・社員、勤怠記録の検索・絞込機能<br>
・ページネーション<br>
・勤怠へのコメント付与<br>
・権限機能<br>

# future functions

・勤怠の申請承認<br>
・csv出力<br>
・メールアドレスを使っての有効化<br>
・パスワードを忘れた際の再発行<br>

# demo

・勤怠打刻(コメントの表示)<br>
https://github.com/furusemaru/attendance-management-app/assets/138269691/f57f43a8-71f3-4f18-8fa7-9e7930d0a598

・社員一覧画面<br>
https://github.com/furusemaru/attendance-management-app/assets/138269691/49171403-bac2-4040-8293-51053c5eb3fd

・勤怠一覧画面<br>
https://github.com/furusemaru/attendance-management-app/assets/138269691/13617c7d-be9d-4b50-81e5-289eed7834f5

# how to use
・トップページ<br>
![スクリーンショット 2024-02-28 192422](https://github.com/furusemaru/attendance-management-app/assets/138269691/c7b44b3f-4776-48d6-a2ab-2d17924f2941)


・ログインページ<br>
![スクリーンショット 2024-02-28 192503](https://github.com/furusemaru/attendance-management-app/assets/138269691/0e531b59-0f30-433c-aa39-adccf8c5dc63)
登録されたメールアドレス・パスワードの組み合わせでログインできます。

・管理者トップページ（管理者のみ）<br>
![スクリーンショット 2024-02-28 192625](https://github.com/furusemaru/attendance-management-app/assets/138269691/97eceae9-f92d-4107-812f-67035fb69c73)
その月の残業時間が既定値（デフォルトでは35時間）を超えている社員を表示します。
30人以上いればページネーションができます。
月ごとの表示や部署での絞り込みは間に合いませんでした。そのため今月分のみです。そのため月初はあまり利用することはありません。
※自分のDB設計の未熟さ故このページは読み込みが遅いです。


・社員一覧ページ（管理者のみ）<br>
![スクリーンショット 2024-02-28 192912](https://github.com/furusemaru/attendance-management-app/assets/138269691/e9dfc736-d734-49f2-a53e-d63a97fb2007)
会社に属する社員の一覧を表示します。
部署や姓で絞り込むことができます。また先ほどと同様にページネーションも行えます
右の操作から社員の設定や削除が行えます。
名前から各社員の個人ページに遷移します。


・新規登録画面<br>
![スクリーンショット 2024-02-28 193237](https://github.com/furusemaru/attendance-management-app/assets/138269691/2921eb10-f116-4c47-86ba-0000cb117240)
各種設定を行い、新しいユーザーを登録できます。
作成後は社員一覧ページに遷移します。


・ユーザートップページ（自身と管理者のみ）
![スクリーンショット 2024-02-28 193915](https://github.com/furusemaru/attendance-management-app/assets/138269691/0d08b260-d766-441e-bcf7-f71e87a54195)
最初はその月の勤怠記録の一覧が表示されます。
操作で勤怠情報の修正、削除ができます。
また年月で絞り込みが行えます。
下部にはその月の総労働時間と総残業時間が表示されます。


・打刻ページ<br>
![スクリーンショット 2024-02-28 194147](https://github.com/furusemaru/attendance-management-app/assets/138269691/b604e3d5-bd0b-45b0-afa7-e791376b2a24)
各項目を設定し勤怠情報を登録します。
日付は自動的にその日の日付で作成されます。
また、出勤ボタン、退勤ボタンを押すと押した時間が入力されます。

。勤怠記録画面（管理者のみ）
![スクリーンショット 2024-02-28 194523](https://github.com/furusemaru/attendance-management-app/assets/138269691/b1a9d67c-1cb2-4708-9d96-522494883ab9)
遷移時はその日の勤怠情報の一覧が表示されます。
年月日で検索可能で部署ごとの表示も可能です。
またコメントは表示をクリックすると内容を閲覧できます。



# Technology used

HTML, CSS, JavaScript, Ruby, Rails

# ER diagram

https://drive.google.com/file/d/1lZIDGbyxRrC8xTXfWU336h9zS8LXrJZq/view?usp=sharing

# URL

[勤怠管理](https://attendance-management-app.onrender.com)

# Author
* 作成者<br>
古瀬佑太

* 所属<br>
東京工業大学大学院　工学院　電気電子系　修士1年

* E-mail<br>
furuse_yuta@icloud.com

# License
 
attendance-management-app is under [MIT license](https://en.wikipedia.org/wiki/MIT_License).
