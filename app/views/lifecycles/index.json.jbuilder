json.array!(@lifecycles) do |lifecycle|
  json.extract! lifecycle, :id
  json.url lifecycle_url(lifecycle, format: :json)
end
