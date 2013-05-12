class CompaniesController < ApplicationController

  require 'crunchbase'

  # requires user authentication before displaying information
  before_filter :authenticate_user!

  # helper methods for sorting by
  helper_method :sort_column, :sort_direction


  # diplay list of all companies
  def index
    # if user filters by category
    if params[:category]
      @companies = Company.filter_by_category(params[:category]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])

      # if user filters by rating
    elsif params[:rating]
      @companies = Company.filter_by_rating(params[:rating]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])

      # display all companies
    else
      @companies = Company.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    end
  end

  # display a particular company page
  def show
    @company = Company.find(params[:id])

    # because you can review either a company or a partner, both company and partner are considered a reviewable.
    # each review belongs to this phantom reviewable object that is indeed a company
    @reviewable = @company
    @reviews = @reviewable.reviews
    @review = Review.new

    @partners = @company.partners
    @partner = Partner.new
  end


  # GET new company page
  # create a new company. users are encouraged to first search the crunchbase database for companies,
  # then enter more information
  def new

    # if users did not enter all fields when the companies#create method is called,
    # params[:failed_to_create] will be true and it will display message telling user to fill out all the fields
    if params[:failed_to_create]
      @failed_to_create = true
    end

    @company = Company.new

    # if the user searches for teh company, show the top 10 results from crunchbase
    if params[:search]
      @crunchbase_companies = Crunchbase::Search.find(params[:search]).first(10)
    end

  end

  # GET company edit page
  def edit
    @company = Company.find(params[:id])
  end

  # POST companies
  # creates the company object from values in the company create form
  def create

    # if company is added from crunchbase and :name is defined (not always the case due to Crunchbase limitations)
    if params[:add_from_crunchbase] && params[:name]

      # cleans the name so that only alphanumeric and space characters are preserved
      name = params[:name]
      name = name.to_s.gsub(/[^0-9a-zA-Z ]/i, '')

      # cleans the description to strip special & markup characters from crunchbase API
      description = params[:description].to_s
      description = clean_description(description)

      # sets the company parameters
      @company = Company.new
      @company.description = description
      @company.name = name
      @company.url = params[:company][:url]
      @company.location = params[:company][:location]
      @company.category = params[:company][:category]

      # if the company is not added from crunchbase (AKA user manually entered all information)
    else
      @company = Company.new(params[:company])
    end

    if @company.save
      redirect_to @company
    else
      # redirect back to new with parameter :failed_to_create
      redirect_to new_company_path(:failed_to_create => :true)
    end
  end

  # PUT /companies/1
  # update the company info
  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      redirect_to @company
    else
      render :action => 'edit'
    end
  end

  private

  # sorts the columns
  def sort_column
    Company.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  # sorts by direction
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # cleans company description imported from crunchbase
  def clean_description (value)
    cleaned_value = value
    cleaned_value.gsub!(/\\r\\n|\\r|\\n/, "<br>")
    cleaned_value.gsub!("[","")
    cleaned_value.gsub!("]","")
    cleaned_value.gsub!('"','')
    cleaned_value.gsub!('n*','')
    return cleaned_value
  end

end
