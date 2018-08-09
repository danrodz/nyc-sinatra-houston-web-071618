require 'pry'

class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/:id' do  
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do  
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end
  
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end


  post '/figures' do
    new_figure = Figure.create(params['figure'])
    
    unless params['title']['name'] == ''
      new_figure.titles << Title.create(params['title'])
    end

    unless params['landmark']['name'] == ''
      new_figure.landmarks << Landmark.create(params['landmark'])
    end
    new_figure.save
    erb :'/figures'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  post '/figures/:id' do 
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
