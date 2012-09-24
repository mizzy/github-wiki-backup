# GitHub Wiki バックアップ用ツール

ペパボ社内で使っている、GitHub Wiki バックアップ用のツールです。特に公開してまずい情報もないので公開します。

## ペパボの中の人向け

バックアップ Wiki には、http://gollum.tokyo.pb/ でアクセスできます。（編集はしないようにしてください。コンフリクトするので。編集系のボタンは一応隠してます。）

バックアップ対象の Wiki リポジトリを追加して欲しい場合には、scripts/setup.rb の以下の部分に追加して、pull request を paperboy-all/github-wiki-backup の方に送ってください。

```ruby
repos = %w!
  paperboy-all/all.wiki
  paperboy-sqale/sqale-app.wiki
!
```

バックアップは30分毎に取得してます。

また、画像は参照できません。（パスによって、参照できたりできなかったりで、よくわからない。）


