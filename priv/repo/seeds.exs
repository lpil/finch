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

if Mix.env == "dev" do

  alias Finch.Bundle

  [
    %Bundle{ display_name: "Battle Chest", code: "battle-chest" },
    %Bundle{ display_name: "Westwood Gold Edition", code: "westwood-gold" },
    %Bundle{ display_name: "Monkey Island Loot", code: "guybrush" },
  ] |> Enum.each(&Finch.Repo.insert!/1)

end
