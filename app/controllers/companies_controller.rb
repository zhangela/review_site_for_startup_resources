class CompaniesController < ApplicationController


  require 'crunchbase'


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

    if params[:search]
      Crunchbase::API.key = 'qcmsjxr83x7dyqhd9ppp4zev'
      @crunchbase_companies = Crunchbase::Search.find(params[:search]).first(10)
    end

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

    if params[:add_from_crunchbase] && params[:name]

      name = params[:name]
      name = name.to_s.gsub(/[^0-9a-zA-Z ]/i, '')

      description = params[:description]
      description = description.to_s.gsub(/[^0-9a-zA-Z,.!:;""''?@#$&*()- ]/i, '')

      @company = Company.new
      @company.description = description
      @company.name = name
      @company.url = params[:company][:url]
      @company.location = params[:company][:location]
      @company.category = params[:company][:category]

    else
      @company = Company.new(params[:company])
    end

    if @company.save
      flash[:notice] = "Successfully created company."
      redirect_to @company
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



  def search_crunchbase
    companies = Array.new
    result = JSON.parse(open("http://api.crunchbase.com/v/1/company/" + params[:crunchbase_search] + "ycombinator.js?api_key=qcmsjxr83x7dyqhd9ppp4zev").read)
    result.each do |company|
      companies << company["name"]
    end

    @crunchbase_companies = result
    @crunchbase_companies_names = companies
  end

end
