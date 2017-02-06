# README

一个购物网站

使用Rails 5编写

运行 `git clone https://github.com/dupeng83/gouwu3` 之后运行以下命令:

`cd gouwu3`

`bundle install --without production`

`rails db:migrate`

`rails db:seed`

`rails server`

使用管理员帐号登录后可以点击导航栏admin链接创建新商品和处理订单, 管理员账户密码信息在db/seed.rb文件中设置. 默认的是用户名"admin@example.com", 密码"password".

部署在[heroku上](https://intense-eyrie-71840.herokuapp.com/)