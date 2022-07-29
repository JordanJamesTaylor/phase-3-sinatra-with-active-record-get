class ApplicationController < Sinatra::Base

  #Set content to JSON, overrides default (Content-Type: text/html)
  set :default_content_type, 'application/json'

  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    #Get access to Review model when making a fetch request to get data from the Game model
    #game.to_json(include: :reviews)

    #To grab User associated with Review
    #game.to_json(include: { reviews: { include: :user } })

    game.to_json(only: [:id, :title, :genre, :price], include: { 
    reviews: { only: [:comment, :score], include: {
    user: { only: [:name] }
    } }
    })
    
    # game.to_json(include: :reviews) returns
  # {
    #"id": 1,
    #"title": "Banjo-Kazooie: Grunty's Revenge",
    #"genre": "Real-time strategy",
    #"platform": "Nintendo DSi",
    #"price": 46,
    #"created_at": "2021-07-19T21:55:24.266Z",
    #"updated_at": "2021-07-19T21:55:24.266Z",
    #"reviews": [
      #  {
      #    "id": 1,
      #    "score": 9,
      #    "comment": "Qui dolorem dolores occaecati.",
      #    "game_id": 1,
      #    "created_at": "2021-07-19T21:55:24.292Z",
      #    "updated_at": "2021-07-19T21:55:24.292Z",
      #    "user_id": 2
      #  },
      #  {
      #    "id": 2,
      #    "score": 3,
      #    "comment": "Omnis tempora sequi ut.",
      #    "game_id": 1,
      #    "created_at": "2021-07-19T21:55:24.295Z",
      #    "updated_at": "2021-07-19T21:55:24.295Z",
      #    "user_id": 5
      #  }
    #]
  #}

  #game.to_json(only: [:id, :title, :genre, :price], include: { 
    # reviews: { only: [:comment, :score], include: {
    # user: { only: [:name] }
    #} }
    #})

    #line 61-65 returns...
#    {
#  "id": 1,
#  "title": "Banjo-Kazooie: Grunty's Revenge",
#  "genre": "Real-time strategy",
#  "price": 46,
#  "reviews": [
#    {
#      "score": 9,
#      "comment": "Qui dolorem dolores occaecati.",
#      "user": {
#        "name": "Miss Landon Boehm"
#      }
#    },
#    {
#      "score": 3,
#      "comment": "Omnis tempora sequi ut.",
#      "user": {
#        "name": "The Hon. Del Ruecker"
#      }
#    }
#  ]
#}
  end

end
