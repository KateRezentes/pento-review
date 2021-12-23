alias Pento.Catalog

products = [
  %{
    name: "Chess",
    description: "The classic strategy game",
    sku: 5_678_910,
    unit_price: 10.00
  },
  %{},
  %{}
]

Enum.each(products, fn product -> Catalog.create_product(product) end)
