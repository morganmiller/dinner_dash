class Admin::CategoriesController < Admin::BaseController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully created!"
      redirect_to admin_category_path(@category.id)
    else
      flash[:errors] = @category.errors.full_messages.join(", ")
      redirect_to new_admin_category_path
    end
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
