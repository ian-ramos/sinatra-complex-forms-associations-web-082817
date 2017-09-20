class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name]) # wby does this fail w/o name:
      @pet.update(owner_id: @owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  post '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if !params[:owner][:name].empty? #essentially overwriting the update made to owner in previous line if there is an owner here
      @owner = Owner.create(name: params[:owner][:name])
      @pet.update(owner_id: @owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end
end
