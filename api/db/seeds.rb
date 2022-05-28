# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
return unless Rails.env.development?

ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.truncate_tables(table.to_sym)
end

Project.create([{ name: "Chaty" }, { name: "Liverl" }])
screen = Project.first.screens.build
screen.name = "React"
screen.url = "/console/reacts"
screen.save

tc = screen.test_cases.build
tc.url = "/console/reacts"
tc.name = "test react"
tc.steps = [
  {
    "command": "open",
    "selector_type": "url",
    "selector_path": "https://chaty:chaty@behemoth.liez.jp/console/reacts/",
    "value": ""
  },
  {
    "command": "click",
    "selector_type": "css",
    "selector_path": "tr:nth-child(1) .mdi-pencil",
    "value": ""
  },
  {
    "command": "click",
    "selector_type": "css",
    "selector_path": ".mdi-chat-outline",
    "value": ""
  },
  {
    "command": "click",
    "selector_type": "css",
    "selector_path": "#reactTextCollapse > .form-control",
    "value": ""
  },
  {
    "command": "type",
    "selector_type": "css",
    "selector_path": "#reactTextCollapse > .form-control",
    "value": "qqqqqqq"
  },
  {
    "command": "click",
    "selector_type": "css",
    "selector_path": ".btn-primary",
    "value": ""
  },
  {
    "command": "waitForText",
    "selector_type": "css",
    "selector_path": ".toasted-container.top-right",
    "value": "キーワード応答を更新しました"
  }
]
tc.save

scenario = Project.first.scenarios.build
scenario.name = "Login"
scenario.url = "https://chaty:chaty@behemoth.liez.jp/users/sign_in"
scenario.steps = [{
  "command": "type",
  "selector_type": "id",
  "selector_path": "email",
  "value": "truongnd@behemoth.vn"
}, {
  "command": "type",
  "selector_type": "id",
  "selector_path": "password",
  "value": "12341234"
}, {
  "command": "click",
  "selector_type": "xpath",
  "selector_path": "//button[@type='submit']"
}, {
  "command": "waitForText",
  "selector_type": "css",
  "selector_path": ".breadcrumb-item > span",
  "value": "ダッシュボード"
}]
scenario.save

scenario = Project.first.scenarios.build
scenario.name = "product_groups_edit"
scenario.url = "https://chaty:chaty@behemoth.liez.jp/console/product_groups"
scenario.steps = [
  {
    "id": "f905e8ab-e799-4e6a-b7f1-24ea468b29ed",
    "comment": "",
    "command": "open",
    "selector_type": "url",
    "selector_path": "https://chaty:chaty@behemoth.liez.jp/console/product_groups",
    "value": ""
  },
  {
    "id": "8e2009ea-633d-4e9f-8301-81c1e21cea52",
    "comment": "",
    "command": "mouseOver",
    "selector_type": "css",
    "selector_path": "tr:nth-child(1) .text-primary > .mdi",
    "value": ""
  },
  {
    "id": "4cc7c437-79bf-4c98-be08-0cb70bc4765b",
    "comment": "",
    "command": "click",
    "selector_type": "css",
    "selector_path": "tr:nth-child(1) .text-primary > .mdi",
    "value": ""
  },
  {
    "id": "c1ab9f6a-6509-4bfc-ab90-2fd57fdaf865",
    "comment": "",
    "command": "type",
    "selector_type": "xpath",
    "selector_path": "//fieldset[2]/div/div/div/input",
    "value": "test group 22"
  },
  {
    "id": "140ee090-ef5f-48e0-b0bc-225801448e66",
    "comment": "",
    "command": "click",
    "selector_type": "css",
    "selector_path": ".btn-primary",
    "value": ""
  },
  {
    "id": "96f18c3b-ded7-4822-8ac5-61b8db0283de",
    "comment": "",
    "command": "waitForText",
    "selector_type": "css",
    "selector_path": ".toasted-container.top-right",
    "value": "商品グループを更新しました"
  }
]
scenario.save
