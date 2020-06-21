class ItemsController < ApplicationController
    def index
    #@items = Item.all
  end
  
  def show
    # @item = Item.find(params[:id])
  end

  def edit
  end

  def confirm
  end

  def new
    # 商品出品関連
    if user_signed_in?
      @item = Item.new
      @item.item_images.build
      #セレクトボックスの初期値設定
      @category_parent_array = ["---"]
    else
      redirect_to onestep_users_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to  root_path and return
    else
      render :new and return
    end 
  end


  def get_category_children
  @category_children = Category.find(params[:parent_name]).children
  end
  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
  @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private
  def item_params
    params.require(:item).permit(
      :name, 
      :discription,
      :category_id,
      :size_id,
      :condition_id,
      :delivery_price_id,
      :delivery_area_id,
      :delivery_day_id,
      :price,
      :brand_id,
      :item_images_attributes => [:item_image,:_destroy]
    ).merge(seller_id: current_user.id)
  end
end
