json.array!(@items) do |item|
  json.name item.item_name
  json.type item.description
  json.id item.id
end