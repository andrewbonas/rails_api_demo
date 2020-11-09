class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.invalid?
      redirect_to new_kitten_path
      flash.alert = "Try again"
    else
      @kitten.save
      redirect_to kitten_path(@kitten.id)
      flash.alert = "Kitten created"
    end
  end

  def edit
    @kitten = Kitten.find_by(params[:id])
    
    flash.alert = "Kitten Updated"

  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to(@kitten)
    else
      render 'new'
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    flash[:notice] = 'Kitten removed'
    redirect_to root_path

  end

  private

  def kitten_params
    params.require(:kitten).permit( :name, :age, :cuteness, :softness)
  end
end
