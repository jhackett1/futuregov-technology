class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories, only: [:show, :index, :new, :edit, :update, :create]
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :set_category_options, only: [:new, :edit, :update, :create]

  def index
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to @entry, notice: 'Entry successfully created.'
    else
      render :new
      # redirect_to @entry, notice: 'There was a problem. Please check your submission and try again.'
    end
  end

  def update
    @entry.update(entry_params)
    if @entry.save
      redirect_to @entry, notice: 'Entry successfully updated.'
    else
      render :edit
      # redirect_to @entry, notice: 'There was a problem. Please check your submission and try again.'
    end
  end

  def destroy
    @entry.discard
    redirect_to entries_path
  end

  private

  def set_categories
    @categories = Category.all
  end

  def set_entry
    @entry = Entry.find_by slug: params[:slug]
  end

  def set_category_options
    @category_options = Category.all.map{|c| [ c.name, c.id ] }
  end

  def entry_params
    params.require(:entry).permit(:title, :body, :category_id)
  end

end
