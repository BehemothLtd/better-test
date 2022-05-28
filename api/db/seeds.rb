# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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
    "selector_path": "/console/reacts/",
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
