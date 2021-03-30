json.extract! item, :id, :itemnumber, :itemname, :description, :type, :manufacturer, :size, :upc, :imageid, :purchaseid, :created_at, :updated_at
json.url item_url(item, format: :json)
