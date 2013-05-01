class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json

  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    if params[:category]
      @companies = Company.filter(params[:category]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    elsif params[:rating]
      @companies = Company.filter_by_rating(params[:rating]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    else
      @companies = Company.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    @reviewable = @company
    @reviews = @reviewable.reviews
    @review = Review.new

    @partners = @company.partners
    @partner = Partner.new
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new
  end

  def self.filter_by_category(opts = {})
     filter = opts[:filter]
     company = Company.arel_table

     self.where(:category => filter)
   end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    if @company.save
      flash[:notice] = "Successfully created company."
      redirect_to @company
    else
      render :action => 'new'
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      flash[:notice] = "Successfully updated company."
      redirect_to @company
    else
      render :action => 'edit'
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = "Successfully destroyed company."
    redirect_to companies_url
  end


  private

  def sort_column
    Company.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
