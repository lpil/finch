# We use the bang functions (`insert!`, `update!` and so on)
# as they will fail if something goes wrong.

if Mix.env == :dev do

  alias Finch.Repo
  alias Finch.Bundle
  alias Finch.Product
  alias Finch.BundleMembership

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
  # Products
  #

  product_d1 = %Product{
    display_name: "Diablo",
    code: "diablo",
  } |> Repo.insert!

  product_d2 = %Product{
    display_name: "Diablo 2",
    code: "diablo-2",
  } |> Repo.insert!

  product_war3 = %Product{
    display_name: "Warcraft 3",
    code: "war-3",
  } |> Repo.insert!

  product_cnc = %Product{
    display_name: "Command & Conquer",
    code: "cnc",
  } |> Repo.insert!

  product_cnc_ra = %Product{
    display_name: "Command & Conquer: Red Alert",
    code: "cnc-ra",
  } |> Repo.insert!

  product_cnc_ra2 = %Product{
    display_name: "Command & Conquer: Red Alert 2",
    code: "cnc-ra2",
  } |> Repo.insert!

  product_cnc_ts = %Product{
    display_name: "Command & Conquer: Tiberium Sun",
    code: "cnc-ts",
  } |> Repo.insert!

  product_mi = %Product{
    display_name: "Monkey Island",
    code: "monkey-island",
  } |> Repo.insert!

  product_mi2 = %Product{
    display_name: "Monkey Island 2",
    code: "monkey-island-2",
  } |> Repo.insert!


  #
  # Bundle Memberships
  #

  %BundleMembership{
    bundle_id: bundle_battle.id,
    product_id: product_d1.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_battle.id,
    product_id: product_d2.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_battle.id,
    product_id: product_war3.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_westwood.id,
    product_id: product_cnc.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_westwood.id,
    product_id: product_cnc_ra.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_westwood.id,
    product_id: product_cnc_ra2.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_westwood.id,
    product_id: product_cnc_ts.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_monkey.id,
    product_id: product_mi.id,
  } |> Repo.insert!

  %BundleMembership{
    bundle_id: bundle_monkey.id,
    product_id: product_mi2.id,
  } |> Repo.insert!
end
