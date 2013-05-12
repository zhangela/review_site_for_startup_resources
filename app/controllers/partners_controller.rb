class PartnersController < ApplicationController

  before_filter :authenticate_user!

  # GET /partners/1
  # Shows a particular partner's page
  def show
    @partner = Partner.find(params[:id])

    # because you can review either a company or a partner, both company and partner are considered a reviewable.
    # each review belongs to this phantom reviewable object that is indeed a partner
    @reviewable = @partner
    @reviews = @reviewable.reviews
    @review = Review.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @partner }
    end
  end

  # GET /partners/1/edit
  # Shows the edit page for a partner
  def edit
    @partner = Partner.find(params[:id])
  end

  # POST /partners
  # Creates a partner that belongs to a company
  def create
    @partner = Partner.new(params[:partner])
    @company = Company.find(params[:company_id])
    @partner.company = @company
    @partner.save

    respond_to do |format|
      if @partner.save
        format.html { redirect_to @partner}
        format.json { render json: @partner, status: :created, location: @partner }
      else
        format.html { render action: "new" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # Updates a particular partner's information
  def update
    @partner = Partner.find(params[:id])

    respond_to do |format|
      if @partner.update_attributes(params[:partner])
        format.html { redirect_to @partner }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end
end
