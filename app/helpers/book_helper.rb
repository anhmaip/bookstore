module BookHelper
  def build_options_for_select_category
    @categories = [["All categories", nil]]
    Category.all.order(:sort_order).each do |category|
      @categories << [category.name, category.id]
    end
  end
end