module BookHelper
  def build_options_for_select_category
    @categories = [["All categories", nil]]
    Category.select('name, id').each do |category|
      @categories << [category.name, category.id]
    end
  end
end