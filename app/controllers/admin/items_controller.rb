class Admin::ItemsController < Admin::BaseController
  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    categories = params[:item][:category_ids].to_a.reject(&:empty?)
    # byebug
    if @item.save
      categories.each { |category_id| @item.categories << Category.find(category_id) }
      flash[:notice] = "Item successfully created!"
      redirect_to admin_item_path(@item.id)
    else
      flash[:errors] = @item.errors.full_messages.join(", ")
      redirect_to new_admin_item_path
    end
  end

  def index
    @items = Item.all
    #put in scoped method
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
    @categories = @item.categories.uniq
  end

  def update
    @item = Item.find(params[:id])
    categories = params[:item][:category_ids].to_a.reject(&:empty?)
    if @item.update(item_params)
      @item.categories.destroy_all
      categories.each { |category| @item.categories << Category.find(category) }
      flash[:notice] = "Item was successfully updated!"
      redirect_to admin_item_path(@item.id)
    else
      redirect_to edit_admin_item_path(@item.id)
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path
  end

  private
  def item_params
    params.require(:item).permit(:title, :description, :price, :retired, { :category_ids => [] })
  end
end
