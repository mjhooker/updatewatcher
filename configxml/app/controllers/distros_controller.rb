class DistrosController < ApplicationController
  # GET /distros
  # GET /distros.xml
  def index
    @distros = Distro.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @distros }
    end
  end

  # GET /distros/1
  # GET /distros/1.xml
  def show
    @distro = Distro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @distro }
    end
  end

  # GET /distros/new
  # GET /distros/new.xml
  def new
    @distro = Distro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @distro }
    end
  end

  # GET /distros/1/edit
  def edit
    @distro = Distro.find(params[:id])
  end

  # POST /distros
  # POST /distros.xml
  def create
    @distro = Distro.new(params[:distro])

    respond_to do |format|
      if @distro.save
        flash[:notice] = 'Distro was successfully created.'
        format.html { redirect_to(@distro) }
        format.xml  { render :xml => @distro, :status => :created, :location => @distro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @distro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /distros/1
  # PUT /distros/1.xml
  def update
    @distro = Distro.find(params[:id])

    respond_to do |format|
      if @distro.update_attributes(params[:distro])
        flash[:notice] = 'Distro was successfully updated.'
        format.html { redirect_to(@distro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @distro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /distros/1
  # DELETE /distros/1.xml
  def destroy
    @distro = Distro.find(params[:id])
    @distro.destroy

    respond_to do |format|
      format.html { redirect_to(distros_url) }
      format.xml  { head :ok }
    end
  end
end
