class DistropackagesController < ApplicationController
  # GET /distropackages
  # GET /distropackages.xml
  def index
    @distropackages = Distropackage.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @distropackages }
    end
  end

  # GET /distropackages/1
  # GET /distropackages/1.xml
  def show
    @distropackage = Distropackage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @distropackage }
    end
  end

  # GET /distropackages/new
  # GET /distropackages/new.xml
  def new
    @distropackage = Distropackage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @distropackage }
    end
  end

  # GET /distropackages/1/edit
  def edit
    @distropackage = Distropackage.find(params[:id])
  end

  # POST /distropackages
  # POST /distropackages.xml
  def create
    @distropackage = Distropackage.new(params[:distropackage])

    respond_to do |format|
      if @distropackage.save
        flash[:notice] = 'Distropackage was successfully created.'
        format.html { redirect_to(@distropackage) }
        format.xml  { render :xml => @distropackage, :status => :created, :location => @distropackage }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @distropackage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /distropackages/1
  # PUT /distropackages/1.xml
  def update
    @distropackage = Distropackage.find(params[:id])

    respond_to do |format|
      if @distropackage.update_attributes(params[:distropackage])
        flash[:notice] = 'Distropackage was successfully updated.'
        format.html { redirect_to(@distropackage) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @distropackage.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /distropackages/1
  # DELETE /distropackages/1.xml
  def destroy
    @distropackage = Distropackage.find(params[:id])
    @distropackage.destroy

    respond_to do |format|
      format.html { redirect_to(distropackages_url) }
      format.xml  { head :ok }
    end
  end
end
