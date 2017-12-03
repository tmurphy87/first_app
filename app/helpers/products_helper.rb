module ProductsHelper
	def cache_key_for_products
    count          = @products #changed from Product.count to fix broken search
    max_updated_at = Product.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "products/all-#{count}-#{max_updated_at}"
  end
end
