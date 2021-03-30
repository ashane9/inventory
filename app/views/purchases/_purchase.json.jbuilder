json.extract! purchase, :id, :invoice_number, :purchase_type, :location, :date, :source, :sale_price, :buyer_premium, :shipping, :total_cost, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
