# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Finch.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

if Mix.env !== :dev do
  raise "Seeds should only be run in the dev environment."
end

alias Finch.FAQ

faqs = [
  %FAQ{ question: "Is it good?",       answer: "Yes." },
  %FAQ{ question: "Favourite colour?", answer: "Blue. No, yellow." },
]

for faq <- faqs do
  Finch.Repo.insert!( faq )
end
