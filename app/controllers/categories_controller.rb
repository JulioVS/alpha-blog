class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show] 
  before_action :set_article, only: [:show, :edit, :update] 

  def show
    # Paginado de los articulos de la categoria
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    # Paginado de todas las categorías
    # JE => Entre "Category" y ".paginate" agregué ".order(:name)" para que 
    #       las categorías se desplieguen alfabéticamente y no por orden de
    #       de creación.-
    @categories = Category.order(:name).paginate(page: params[:page], per_page: 5) 
  end

  def new 
    @category = Category.new 
  end

  def edit
    # 'set_article' se llama automaticamente para esta y otras acciones
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category name succesfully updated"
      redirect_to @category
    else
      flash[:alert] = "You ain't too bright, aren't ya...? FAIL!"
      render 'edit'
    end
  end

  def create
    @category = Category.new(category_params) 
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category 
    else
      render 'new'
    end
  end
  
  private

  def set_article
    @category = Category.find(params[:id]) 
  end

  def category_params
    params.require(:category).permit(:name) 
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You shall not pass!!! Only Admins allowed!"
      redirect_to categories_path
    else
      flash[:notice] = "Welcome Admin! Your are good to go!"
    end
  end
end