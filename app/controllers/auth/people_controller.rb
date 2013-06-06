class Auth::PeopleController < ApplicationController
  # GET /auth/people
  # GET /auth/people.json
  def index
    @auth_people = Auth::Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @auth_people }
    end
  end

  # GET /auth/people/1
  # GET /auth/people/1.json
  def show
    @auth_person = Auth::Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @auth_person }
      #format.xml { render :xml => @auth_person }
      #format.json # show.json.erb
    end
  end

  # GET /auth/people/new
  # GET /auth/people/new.json
  def new
    @auth_person = Auth::Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @auth_person }
    end
  end

  # GET /auth/people/1/edit
  def edit
    @auth_person = Auth::Person.find(params[:id])
  end

  # POST /auth/people
  # POST /auth/people.json
  def create
    @auth_person = Auth::Person.new(params[:auth_person])

    respond_to do |format|
      if @auth_person.save
        format.html { redirect_to @auth_person, notice: 'Person was successfully created.' }
        format.json { render json: @auth_person, status: :created, location: @auth_person }
      else
        format.html { render action: "new" }
        format.json { render json: @auth_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /auth/people/1
  # PUT /auth/people/1.json
  def update
    @auth_person = Auth::Person.find(params[:id])

    respond_to do |format|
      if @auth_person.update_attributes(params[:auth_person])
        format.html { redirect_to @auth_person, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @auth_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auth/people/1
  # DELETE /auth/people/1.json
  def destroy
    @auth_person = Auth::Person.find(params[:id])
    @auth_person.destroy

    respond_to do |format|
      format.html { redirect_to auth_people_url }
      format.json { head :no_content }
    end
  end
end
