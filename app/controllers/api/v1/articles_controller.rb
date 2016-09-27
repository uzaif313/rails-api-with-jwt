class Api::V1::ArticlesController < Api::V1::BaseController
  before_filter :authenticate_user_with_token!, except: [:index, :show]
  
  def index
		articles = Article.all
		render json:{articles:articles}  	
  end


  def create
  	article = @current_user.articles.create(article_params)
  	render json:{article:article,user:current_user}
  end

  def show
  	article = Article.find(params[:id]) unless article.nil?
  	render json:{article:article} 
  end

  def destroy
  	article = Article.find(params[:id])
  	article = article.destroy if @current_user.id ==article.user_id
  	if article.errors.present?
  		render json:{error:article.errors.messages}
  	else
  		render json:{article:article}
  	end
  end

  private
  	def article_params
  		params.require(:article).permit(:title,:description)
  	end
end
