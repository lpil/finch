# We use the bang functions (`insert!`, `update!` and so on)
# as they will fail if something goes wrong.

if Mix.env == :dev do

  alias Finch.User
  alias Finch.Repo
  alias Finch.Bundle
  alias Finch.Item
  alias Finch.BundleEntry

  #
  # Bundles
  #

  bundle_battle = %Bundle{
    display_name: "Battle Chest",
    code: "battle-chest",
  } |> Repo.insert!

  bundle_westwood = %Bundle{
    display_name: "Westwood Gold Edition",
    code: "westwood-gold",
  } |> Repo.insert!

  bundle_monkey = %Bundle{
    display_name: "Monkey Island Loot",
    code: "guybrush",
  } |> Repo.insert!


  #
  # Items
  #

  item_d1 = %Item{
    display_name: "Diablo",
    code: "diablo",
  } |> Repo.insert!

  item_d2 = %Item{
    display_name: "Diablo 2",
    code: "diablo-2",
  } |> Repo.insert!

  item_war3 = %Item{
    display_name: "Warcraft 3",
    code: "war-3",
  } |> Repo.insert!

  item_cnc = %Item{
    display_name: "Command & Conquer",
    code: "cnc",
  } |> Repo.insert!

  item_cnc_ra = %Item{
    display_name: "Command & Conquer: Red Alert",
    code: "cnc-ra",
  } |> Repo.insert!

  item_cnc_ra2 = %Item{
    display_name: "Command & Conquer: Red Alert 2",
    code: "cnc-ra2",
  } |> Repo.insert!

  item_cnc_ts = %Item{
    display_name: "Command & Conquer: Tiberium Sun",
    code: "cnc-ts",
  } |> Repo.insert!

  item_mi = %Item{
    display_name: "Monkey Island",
    code: "monkey-island",
  } |> Repo.insert!

  item_mi2 = %Item{
    display_name: "Monkey Island 2",
    code: "monkey-island-2",
  } |> Repo.insert!


  #
  # Bundle Entrys
  #

  %BundleEntry{
    bundle_id: bundle_battle.id,
    item_id: item_d1.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_battle.id,
    item_id: item_d2.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_battle.id,
    item_id: item_war3.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_westwood.id,
    item_id: item_cnc.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_westwood.id,
    item_id: item_cnc_ra.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_westwood.id,
    item_id: item_cnc_ra2.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_westwood.id,
    item_id: item_cnc_ts.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_monkey.id,
    item_id: item_mi.id,
  } |> Repo.insert!

  %BundleEntry{
    bundle_id: bundle_monkey.id,
    item_id: item_mi2.id,
  } |> Repo.insert!

  #
  # A user to log in with!
  #

  password = "12345678"
  user = %User{} |> User.changeset(%{
    email: "a@b.c",
    password: password,
    password_confirmation: password,
  }) |> Repo.insert!

  IO.puts "Email:    #{user.email}"
  IO.puts "Password: #{password}"
end
