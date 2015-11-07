# We use the bang functions (`insert!`, `update!` and so on)
# as they will fail if something goes wrong.

if Mix.env == :dev do

  alias Finch.Bundle

  [
    %Bundle{ display_name: "Battle Chest", code: "battle-chest" },
    %Bundle{ display_name: "Westwood Gold Edition", code: "westwood-gold" },
    %Bundle{ display_name: "Monkey Island Loot", code: "guybrush" },
  ] |> Enum.each(&Finch.Repo.insert!/1)

end
